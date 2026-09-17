import 'package:equatable/equatable.dart';

import 'property_entity.dart';

class HomeDataEntity extends Equatable {
  final String? locationName;
  final List<String> propertyTypes;
  final List<PropertyEntity> aiMatchedProperties;
  final List<PropertyEntity> nearbyProperties;

  const HomeDataEntity({
    required this.locationName,
    required this.propertyTypes,
    required this.aiMatchedProperties,
    required this.nearbyProperties,
  });

  @override
  List<Object?> get props => [
    locationName,
    propertyTypes,
    aiMatchedProperties,
    nearbyProperties,
  ];
}
