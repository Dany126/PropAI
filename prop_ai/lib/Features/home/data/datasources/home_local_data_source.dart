import 'package:prop_ai/core/storage/app_preferences.dart';

import '../models/home_data_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeDataModel> getHomeData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeDataModel> getHomeData() async {
    final location = AppPreferences.locationName ?? 'Dubai Marina';

    return HomeDataModel.fromMap({
      'locationName': location,
      'propertyTypes': ['All Properties', 'Apartments', 'Villas', 'Penthouses'],
      'aiMatchedProperties': [
        {
          'id': 'property_1',
          'title': 'Panoramic Suite',
          'location': 'Dubai Marina',
          'imageUrl':
              'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c',
          'price': 2450000,
          'priceLabel': 'AED 2,450,000',
          'bedrooms': 2,
          'bathrooms': 2,
          'areaSqft': 1420,
          'propertyType': 'Apartment',
          'matchPercentage': 98,
          'rating': 4.9,
          'reviewCount': 128,
          'badge': 'High ROI',
          'smartMatch': 'Sea view, 2 beds, below 2.5M',
          'isVerified': true,
          'isFavorite': false,
        },
        {
          'id': 'property_2',
          'title': 'Palm Jumeirah Residence',
          'location': 'Palm Jumeirah',
          'imageUrl':
              'https://images.unsplash.com/photo-1600566753086-00f18fb6b3a5',
          'price': 3200000,
          'priceLabel': 'AED 3,200,000',
          'bedrooms': 3,
          'bathrooms': 3,
          'areaSqft': 1800,
          'propertyType': 'Apartment',
          'matchPercentage': 94,
          'rating': 4.8,
          'reviewCount': 96,
          'badge': null,
          'smartMatch': 'Beach access, 3 beds, premium area',
          'isVerified': true,
          'isFavorite': false,
        },
      ],
      'nearbyProperties': [
        {
          'id': 'property_1',
          'title': 'Luxury Marina Apartment',
          'location': 'Dubai Marina',
          'imageUrl':
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
          'price': 2800000,
          'priceLabel': 'AED 2,800,000',
          'bedrooms': 2,
          'bathrooms': 2,
          'areaSqft': 1500,
          'propertyType': 'Apartment',
          'matchPercentage': 91,
          'rating': 4.7,
          'reviewCount': 72,
          'badge': 'Verified DLD',
          'smartMatch': null,
          'isVerified': true,
          'isFavorite': false,
        },
        {
          'id': 'property_2',
          'title': 'Modern Waterfront Villa',
          'location': 'Jumeirah',
          'imageUrl':
              'https://images.unsplash.com/photo-1613490493576-7fde63acd811',
          'price': 5800000,
          'priceLabel': 'AED 5,800,000',
          'bedrooms': 4,
          'bathrooms': 5,
          'areaSqft': 3200,
          'propertyType': 'Villa',
          'matchPercentage': 89,
          'rating': 4.9,
          'reviewCount': 51,
          'badge': 'Price Dropped 4%',
          'smartMatch': null,
          'isVerified': true,
          'isFavorite': false,
        },
      ],
    });
  }
}
