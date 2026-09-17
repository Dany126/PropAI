import 'package:equatable/equatable.dart';

class PropertyDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final String description;

  final double price;
  final String priceLabel;

  final int bedrooms;
  final int bathrooms;
  final double areaSqft;

  final String propertyType;

  final List<String> images;
  final List<String> features;
  final List<String> amenities;

  final int matchPercentage;
  final String? matchReason;

  final double rating;
  final int reviewCount;

  final String? badge;
  final bool isVerified;
  final bool isFavorite;

  final double latitude;
  final double longitude;

  const PropertyDetailsEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.priceLabel,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.propertyType,
    required this.images,
    required this.features,
    required this.amenities,
    required this.matchPercentage,
    required this.matchReason,
    required this.rating,
    required this.reviewCount,
    required this.badge,
    required this.isVerified,
    required this.isFavorite,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    description,
    price,
    priceLabel,
    bedrooms,
    bathrooms,
    areaSqft,
    propertyType,
    images,
    features,
    amenities,
    matchPercentage,
    matchReason,
    rating,
    reviewCount,
    badge,
    isVerified,
    isFavorite,
    latitude,
    longitude,
  ];
}
