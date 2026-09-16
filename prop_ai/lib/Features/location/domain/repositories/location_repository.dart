import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity?> getSavedLocation();

  Future<void> saveLocation(LocationEntity location);

  Future<LocationEntity> getCurrentLocation();

  Future<void> clearLocation();
}
