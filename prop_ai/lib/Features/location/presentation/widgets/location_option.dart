import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/location_entity.dart';

class LocationOption extends StatelessWidget {
  final LocationEntity location;
  final VoidCallback onTap;
  final bool isRecent;

  const LocationOption({
    super.key,
    required this.location,
    required this.onTap,
    this.isRecent = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.gray100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on,
                color: AppColors.gray500,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        location.name,
                        style: AppTextStyle.semiBold16.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                      if (isRecent) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'RECENT',
                            style: AppTextStyle.semiBold12.copyWith(
                              color: AppColors.gray600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (location.country != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      location.country!,
                      style: AppTextStyle.regular14.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}
