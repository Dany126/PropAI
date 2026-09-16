import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImpl({required this.localDataSource});

  @override
  Future<LocationEntity?> getSavedLocation() async {
    return localDataSource.getSavedLocation();
  }

  @override
  Future<void> saveLocation(LocationEntity location) async {
    await localDataSource.saveLocation(location);
  }

  @override
  Future<void> clearLocation() async {
    await localDataSource.clearLocation();
  }

  @override
  Future<LocationEntity> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        'Location services are disabled. Please enable location services.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission was denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission is permanently denied. '
        'Please enable it from settings.',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return LocationEntity(
        name: 'Current Location',
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }

    final placemark = placemarks.first;

    final city =
        placemark.locality ??
        placemark.subAdministrativeArea ??
        placemark.administrativeArea ??
        'Current Location';

    final country = placemark.country;

    return LocationEntity(
      name: city,
      country: country,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Future<List<LocationEntity>> searchLocations(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final locations = await locationFromAddress(query);
      final List<LocationEntity> results = [];
      final Set<String> seenNames = {}; // To prevent duplicates

      for (var loc in locations.take(5)) {
        // Limit to top 5 results for speed
        final placemarks = await placemarkFromCoordinates(
          loc.latitude,
          loc.longitude,
        );

        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          final city =
              placemark.locality ??
              placemark.subAdministrativeArea ??
              placemark.administrativeArea ??
              query;
          final country = placemark.country ?? 'Unknown';

          final uniqueKey = '$city, $country';
          if (!seenNames.contains(uniqueKey)) {
            seenNames.add(uniqueKey);
            results.add(
              LocationEntity(
                name: city,
                country: country,
                latitude: loc.latitude,
                longitude: loc.longitude,
              ),
            );
          }
        }
      }

      return results;
    } catch (e) {
      // If the geocoder fails (e.g. no results found or network error), return empty
      return [];
    }
  }

  @override
  Future<List<LocationEntity>> getRecentLocations() async {
    return localDataSource.getRecentLocations();
  }

  @override
  Future<void> addRecentLocation(LocationEntity location) async {
    await localDataSource.addRecentLocation(location);
  }

  @override
  Future<void> removeRecentLocation(LocationEntity location) async {
    await localDataSource.removeRecentLocation(location);
  }
}
