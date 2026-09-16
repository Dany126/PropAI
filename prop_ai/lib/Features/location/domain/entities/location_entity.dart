import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String name;
  final String? country;
  final double? latitude;
  final double? longitude;

  const LocationEntity({
    required this.name,
    this.country,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocationEntity.fromMap(Map<String, dynamic> map) {
    return LocationEntity(
      name: map['name'] as String,
      country: map['country'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
    );
  }

  String get displayName {
    if (country == null || country!.isEmpty) {
      return name;
    }

    return '$name, $country';
  }

  @override
  List<Object?> get props => [name, country, latitude, longitude];
}
