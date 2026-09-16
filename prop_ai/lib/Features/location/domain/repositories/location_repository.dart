import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity?> getSavedLocation();

  Future<void> saveLocation(LocationEntity location);

  Future<LocationEntity> getCurrentLocation();

  Future<List<LocationEntity>> searchLocations(String query);

  Future<void> clearLocation();

  Future<List<LocationEntity>> getRecentLocations();
  
  Future<void> addRecentLocation(LocationEntity location);
  
  Future<void> removeRecentLocation(LocationEntity location);
}
