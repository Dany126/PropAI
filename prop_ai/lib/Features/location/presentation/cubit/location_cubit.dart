import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository repository;
  Timer? _searchTimer;

  LocationCubit({required this.repository}) : super(const LocationState());

  Future<void> loadSavedLocation() async {
    try {
      final location = await repository.getSavedLocation();
      final recent = await repository.getRecentLocations();

      emit(state.copyWith(recentLocations: recent));

      if (location == null) {
        emit(state.copyWith(status: LocationStatus.initial));
        return;
      }

      emit(
        state.copyWith(
          status: LocationStatus.success,
          selectedLocation: location,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> useCurrentLocation() async {
    emit(state.copyWith(status: LocationStatus.loading, clearError: true));

    try {
      final location = await repository.getCurrentLocation();

      emit(
        state.copyWith(
          status: LocationStatus.success,
          currentLocation: location,
          selectedLocation: location,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: _cleanErrorMessage(e),
        ),
      );
    }
  }

  void selectLocation(LocationEntity location) {
    emit(
      state.copyWith(
        selectedLocation: location,
        status: LocationStatus.success,
        clearError: true,
      ),
    );
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query, clearError: true));

    _searchTimer?.cancel();

    if (query.trim().isEmpty) {
      emit(state.copyWith(searchResults: [], isSearching: false));
      return;
    }

    emit(state.copyWith(isSearching: true));

    _searchTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final results = await repository.searchLocations(query);
        if (!isClosed) {
          emit(state.copyWith(searchResults: results, isSearching: false));
        }
      } catch (e) {
        if (!isClosed) {
          emit(state.copyWith(searchResults: [], isSearching: false));
        }
      }
    });
  }

  void proceedToSearch() {
    emit(state.copyWith(showSearchScreen: true, clearError: true));
  }

  void cancelSearch() {
    emit(state.copyWith(showSearchScreen: false, clearError: true));
  }

  Future<void> saveSelectedLocation() async {
    final location = state.selectedLocation;

    if (location == null) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: 'Please select a location first.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: LocationStatus.loading, clearError: true));

    try {
      await repository.saveLocation(location);
      await repository.addRecentLocation(location);
      final recent = await repository.getRecentLocations();

      emit(
        state.copyWith(
          status: LocationStatus.success,
          selectedLocation: location,
          recentLocations: recent,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: _cleanErrorMessage(e),
        ),
      );
    }
  }

  Future<void> clearLocation() async {
    await repository.clearLocation();

    emit(
      state.copyWith(
        status: LocationStatus.initial,
        clearSelectedLocation: true,
        clearCurrentLocation: true,
      ),
    );
  }

  Future<void> deleteRecentLocation(LocationEntity location) async {
    try {
      await repository.removeRecentLocation(location);
      final recent = await repository.getRecentLocations();
      emit(state.copyWith(recentLocations: recent));
    } catch (e) {
      // Ignore
    }
  }

  String _cleanErrorMessage(Object error) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.substring('Exception: '.length);
    }

    return message;
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
