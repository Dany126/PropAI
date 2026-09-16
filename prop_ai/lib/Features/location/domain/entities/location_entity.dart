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

  String get displayName {
    if (country == null || country!.isEmpty) {
      return name;
    }

    return '$name, $country';
  }

  @override
  List<Object?> get props => [name, country, latitude, longitude];
}
