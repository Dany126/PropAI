import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TimeSlotCard extends StatelessWidget {
  final String label;
  final String time;
  final bool selected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.label,
    required this.time,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary50 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary600 : AppColors.gray200,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: AppTextStyle.medium10.copyWith(color: AppColors.gray500),
              ),

              const SizedBox(height: 7),

              Text(
                time,
                style: AppTextStyle.bold16.copyWith(
                  color: selected ? AppColors.primary600 : AppColors.gray800,
                ),
              ),

              const SizedBox(height: 7),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary100
                      : const Color(0xFFE9F9F0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  selected ? 'Selected' : 'Available',
                  style: AppTextStyle.semiBold10.copyWith(
                    color: selected
                        ? AppColors.primary600
                        : const Color(0xFF159447),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
