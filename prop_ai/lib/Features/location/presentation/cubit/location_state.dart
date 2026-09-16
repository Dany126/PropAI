import 'package:equatable/equatable.dart';

import '../../domain/entities/location_entity.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationState extends Equatable {
  final LocationStatus status;
  final LocationEntity? selectedLocation;
  final LocationEntity? currentLocation;
  final String searchQuery;
  final String? errorMessage;
  final bool showSearchScreen;
  final List<String> popularCities;
  final List<LocationEntity> recentLocations;
  final List<LocationEntity> searchResults;

  const LocationState({
    this.status = LocationStatus.initial,
    this.selectedLocation,
    this.currentLocation,
    this.searchQuery = '',
    this.errorMessage,
    this.showSearchScreen = false,
    this.popularCities = const [],
    this.recentLocations = const [],
    this.searchResults = const [],
  });

  LocationState copyWith({
    LocationStatus? status,
    LocationEntity? selectedLocation,
    LocationEntity? currentLocation,
    String? searchQuery,
    String? errorMessage,
    bool? showSearchScreen,
    List<String>? popularCities,
    List<LocationEntity>? recentLocations,
    List<LocationEntity>? searchResults,
    bool clearSelectedLocation = false,
    bool clearCurrentLocation = false,
    bool clearError = false,
  }) {
    return LocationState(
      status: status ?? this.status,
      selectedLocation: clearSelectedLocation
          ? null
          : selectedLocation ?? this.selectedLocation,
      currentLocation: clearCurrentLocation
          ? null
          : currentLocation ?? this.currentLocation,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      showSearchScreen: showSearchScreen ?? this.showSearchScreen,
      popularCities: popularCities ?? this.popularCities,
      recentLocations: recentLocations ?? this.recentLocations,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedLocation,
    currentLocation,
    searchQuery,
    errorMessage,
    showSearchScreen,
    popularCities,
    recentLocations,
    searchResults,
  ];
}
