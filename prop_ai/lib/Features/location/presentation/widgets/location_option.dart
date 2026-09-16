 import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/location_entity.dart';

class LocationOption extends StatelessWidget {
  final LocationEntity location;
  final VoidCallback onTap;
  final bool isRecent;
  final bool isSelected;
  final VoidCallback? onDelete;

  const LocationOption({
    super.key,
    required this.location,
    required this.onTap,
    this.isRecent = false,
    this.isSelected = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary50 : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary600 : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary100 : AppColors.gray100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: isSelected ? AppColors.primary600 : AppColors.gray500,
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
                        Expanded(
                          child: Text(
                            location.name,
                            style: AppTextStyle.semiBold16.copyWith(
                              color: AppColors.gray900,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.primary600,
                            size: 22,
                          ),
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

                    if (isRecent) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
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
              ),

              if (isRecent && onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.close_rounded, color: AppColors.gray400),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                )
              else if (!isSelected)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.gray400,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
