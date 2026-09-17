import '../../domain/entities/property_details_entity.dart';

class PropertyDetailsModel extends PropertyDetailsEntity {
  const PropertyDetailsModel({
    required super.id,
    required super.title,
    required super.location,
    required super.description,
    required super.price,
    required super.priceLabel,
    required super.bedrooms,
    required super.bathrooms,
    required super.areaSqft,
    required super.propertyType,
    required super.images,
    required super.features,
    required super.amenities,
    required super.matchPercentage,
    required super.matchReason,
    required super.rating,
    required super.reviewCount,
    required super.badge,
    required super.isVerified,
    required super.isFavorite,
    required super.latitude,
    required super.longitude,
  });

  factory PropertyDetailsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return PropertyDetailsModel(
      id: map['id'] as String,
      title: map['title'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      priceLabel: map['priceLabel'] as String,
      bedrooms: map['bedrooms'] as int,
      bathrooms: map['bathrooms'] as int,
      areaSqft: (map['areaSqft'] as num).toDouble(),
      propertyType: map['propertyType'] as String,
      images: List<String>.from(map['images'] as List),
      features: List<String>.from(map['features'] as List),
      amenities: List<String>.from(map['amenities'] as List),
      matchPercentage: map['matchPercentage'] as int,
      matchReason: map['matchReason'] as String?,
      rating: (map['rating'] as num).toDouble(),
      reviewCount: map['reviewCount'] as int,
      badge: map['badge'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      isFavorite: map['isFavorite'] as bool? ?? false,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }
}