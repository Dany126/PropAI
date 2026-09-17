import '../models/property_details_model.dart';

abstract class PropertyLocalDataSource {
  Future<PropertyDetailsModel> getPropertyDetails(String propertyId);
}

class PropertyLocalDataSourceImpl implements PropertyLocalDataSource {
  @override
  Future<PropertyDetailsModel> getPropertyDetails(String propertyId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final properties = <String, Map<String, dynamic>>{
      'property_1': {
        'id': 'property_1',
        'title': 'Panoramic Suite',
        'location': 'Dubai Marina, Dubai',
        'description':
            'A beautifully designed waterfront apartment with '
            'panoramic marina views, modern interiors and premium '
            'amenities. The property is located close to the beach, '
            'restaurants and major transportation options.',
        'price': 2450000,
        'priceLabel': 'AED 2.45M',
        'bedrooms': 2,
        'bathrooms': 2,
        'areaSqft': 1420,
        'propertyType': 'Apartment',
        'images': [
          'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
          'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea',
          'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0',
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
        ],
        'features': [
          'Sea View',
          'Balcony',
          'Built-in Wardrobes',
          'Central Air Conditioning',
          'Covered Parking',
          'Smart Home',
        ],
        'amenities': [
          'Swimming Pool',
          'Gym',
          '24/7 Security',
          'Children Playground',
          'Concierge',
        ],
        'matchPercentage': 98,
        'matchReason': 'Sea view, 2 bedrooms and within your preferred budget.',
        'rating': 4.9,
        'reviewCount': 128,
        'badge': 'High ROI',
        'isVerified': true,
        'isFavorite': false,
        'latitude': 25.0800,
        'longitude': 55.1400,
      },

      'property_2': {
        'id': 'property_2',
        'title': 'Palm Jumeirah Residence',
        'location': 'Palm Jumeirah, Dubai',
        'description':
            'Premium residence located in one of Dubai\'s most '
            'recognizable waterfront communities.',
        'price': 3200000,
        'priceLabel': 'AED 3.2M',
        'bedrooms': 3,
        'bathrooms': 3,
        'areaSqft': 1800,
        'propertyType': 'Apartment',
        'images': [
          'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d',
          'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3',
        ],
        'features': ['Sea View', 'Balcony', 'Walk-in Closet', 'Parking'],
        'amenities': ['Pool', 'Gym', 'Security', 'Private Beach'],
        'matchPercentage': 94,
        'matchReason': 'Waterfront location and spacious 3-bedroom layout.',
        'rating': 4.8,
        'reviewCount': 94,
        'badge': 'Popular',
        'isVerified': true,
        'isFavorite': false,
        'latitude': 25.1124,
        'longitude': 55.1390,
      },
    };

    final data = properties[propertyId];

    if (data == null) {
      throw Exception('Property not found');
    }

    return PropertyDetailsModel.fromMap(data);
  }
}
