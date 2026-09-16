import '../../../../core/storage/app_preferences.dart';
import '../../domain/entities/location_entity.dart';

class LocationLocalDataSource {
  Future<LocationEntity?> getSavedLocation() async {
    if (!AppPreferences.locationSelected) {
      return null;
    }

    final name = AppPreferences.locationName;

    if (name == null || name.isEmpty) {
      return null;
    }

    return LocationEntity(name: name);
  }

  Future<void> saveLocation(LocationEntity location) async {
    await AppPreferences.setLocationSelected(true);
    await AppPreferences.setLocationName(location.displayName);
  }

  Future<void> clearLocation() async {
    await AppPreferences.setLocationSelected(false);
    await AppPreferences.setLocationName('');
  }
}
