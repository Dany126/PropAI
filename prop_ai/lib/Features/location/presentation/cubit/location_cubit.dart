import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository repository;

  LocationCubit({required this.repository}) : super(const LocationState());

  Future<void> loadSavedLocation() async {
    try {
      final location = await repository.getSavedLocation();

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

  String _cleanErrorMessage(Object error) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.substring('Exception: '.length);
    }

    return message;
  }
}
