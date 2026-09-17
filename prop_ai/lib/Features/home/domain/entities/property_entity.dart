import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final double price;
  final String priceLabel;
  final int bedrooms;
  final int bathrooms;
  final double areaSqft;
  final String propertyType;
  final int matchPercentage;
  final double rating;
  final int reviewCount;
  final String? badge;
  final String? smartMatch;
  final bool isVerified;
  final bool isFavorite;

  const PropertyEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.priceLabel,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.propertyType,
    required this.matchPercentage,
    required this.rating,
    required this.reviewCount,
    this.badge,
    this.smartMatch,
    this.isVerified = false,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    imageUrl,
    price,
    priceLabel,
    bedrooms,
    bathrooms,
    areaSqft,
    propertyType,
    matchPercentage,
    rating,
    reviewCount,
    badge,
    smartMatch,
    isVerified,
    isFavorite,
  ];
}
