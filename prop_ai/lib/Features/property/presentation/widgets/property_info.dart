import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/property_details_entity.dart';

class PropertyInfo extends StatelessWidget {
  final PropertyDetailsEntity property;

  const PropertyInfo({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (property.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.aiAccent50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    property.badge!,
                    style: AppTextStyle.semiBold12.copyWith(
                      color: AppColors.aiAccent700,
                    ),
                  ),
                ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+${property.matchPercentage}% Match',
                  style: AppTextStyle.semiBold12.copyWith(
                    color: AppColors.primary600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(property.title, style: AppTextStyle.bold18),

          const SizedBox(height: 7),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.gray500,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  property.location,
                  style: AppTextStyle.regular12.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            property.priceLabel,
            style: AppTextStyle.bold18.copyWith(color: AppColors.primary600),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              _InfoItem(
                icon: Icons.bed_outlined,
                value: '${property.bedrooms}',
                label: 'Beds',
              ),
              _Divider(),
              _InfoItem(
                icon: Icons.bathtub_outlined,
                value: '${property.bathrooms}',
                label: 'Baths',
              ),
              _Divider(),
              _InfoItem(
                icon: Icons.square_foot,
                value: '${property.areaSqft.toInt()}',
                label: 'sqft',
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text('About this property', style: AppTextStyle.bold16),

          const SizedBox(height: 10),

          Text(
            property.description,
            style: AppTextStyle.regular14.copyWith(
              color: AppColors.gray600,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 21, color: AppColors.primary600),
          const SizedBox(height: 5),
          Text('$value $label', style: AppTextStyle.semiBold12),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 30, width: 1, color: AppColors.gray200);
  }
}
