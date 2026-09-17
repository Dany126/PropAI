import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/property_details_entity.dart';

class PropertyFeatures extends StatelessWidget {
  final PropertyDetailsEntity property;

  const PropertyFeatures({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Features & Amenities', style: AppTextStyle.bold16),

          const SizedBox(height: 14),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [...property.features, ...property.amenities].map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.gray200),
                ),
                child: Text(
                  item,
                  style: AppTextStyle.medium12.copyWith(
                    color: AppColors.gray700,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
