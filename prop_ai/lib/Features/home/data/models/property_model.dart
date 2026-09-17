import '../../domain/entities/property_entity.dart';

class PropertyModel extends PropertyEntity {
  const PropertyModel({
    required super.id,
    required super.title,
    required super.location,
    required super.imageUrl,
    required super.price,
    required super.priceLabel,
    required super.bedrooms,
    required super.bathrooms,
    required super.areaSqft,
    required super.propertyType,
    required super.matchPercentage,
    required super.rating,
    required super.reviewCount,
    super.badge,
    super.smartMatch,
    super.isVerified,
    super.isFavorite,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'] as String,
      title: map['title'] as String,
      location: map['location'] as String,
      imageUrl: map['imageUrl'] as String,
      price: (map['price'] as num).toDouble(),
      priceLabel: map['priceLabel'] as String,
      bedrooms: map['bedrooms'] as int,
      bathrooms: map['bathrooms'] as int,
      areaSqft: (map['areaSqft'] as num).toDouble(),
      propertyType: map['propertyType'] as String,
      matchPercentage: map['matchPercentage'] as int,
      rating: (map['rating'] as num).toDouble(),
      reviewCount: map['reviewCount'] as int,
      badge: map['badge'] as String?,
      smartMatch: map['smartMatch'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }
}
