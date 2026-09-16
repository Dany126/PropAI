import 'dart:convert';

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

  Future<List<LocationEntity>> getRecentLocations() async {
    final List<String> recentStrings = AppPreferences.recentLocations;
    return recentStrings.map((str) => LocationEntity.fromMap(jsonDecode(str))).toList();
  }

  Future<void> addRecentLocation(LocationEntity location) async {
    final recent = await getRecentLocations();
    
    // Remove if it already exists to avoid duplicates
    recent.removeWhere((loc) => loc.name == location.name);
    
    // Add to top of the list
    recent.insert(0, location);
    
    // Keep only last 5 recent locations
    if (recent.length > 5) {
      recent.removeLast();
    }
    
    final recentStrings = recent.map((loc) => jsonEncode(loc.toMap())).toList();
    await AppPreferences.setRecentLocations(recentStrings);
  }

  Future<void> removeRecentLocation(LocationEntity location) async {
    final recent = await getRecentLocations();
    recent.removeWhere((loc) => loc.name == location.name);
    
    final recentStrings = recent.map((loc) => jsonEncode(loc.toMap())).toList();
    await AppPreferences.setRecentLocations(recentStrings);
  }
}
