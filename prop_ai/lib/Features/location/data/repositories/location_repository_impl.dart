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
}
