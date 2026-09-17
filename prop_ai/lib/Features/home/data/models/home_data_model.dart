import '../../domain/entities/home_data_entity.dart';
import 'property_model.dart';

class HomeDataModel extends HomeDataEntity {
  const HomeDataModel({
    required super.locationName,
    required super.propertyTypes,
    required super.aiMatchedProperties,
    required super.nearbyProperties,
  });

  factory HomeDataModel.fromMap(Map<String, dynamic> map) {
    return HomeDataModel(
      locationName: map['locationName'] as String?,
      propertyTypes: List<String>.from(map['propertyTypes'] as List),
      aiMatchedProperties: (map['aiMatchedProperties'] as List)
          .map(
            (property) =>
                PropertyModel.fromMap(property as Map<String, dynamic>),
          )
          .toList(),
      nearbyProperties: (map['nearbyProperties'] as List)
          .map(
            (property) =>
                PropertyModel.fromMap(property as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
