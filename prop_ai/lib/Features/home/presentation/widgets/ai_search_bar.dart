import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AiSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;

  const AiSearchBar({super.key, this.onTap, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.aiAccent50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.aiAccent100),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    size: 18,
                    color: AppColors.aiAccent600,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Try: "2 bedroom near the beach under 2M"',
                      maxLines: 2,
                      style: AppTextStyle.medium12.copyWith(
                        color: AppColors.gray600,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.mic_none_rounded,
                    size: 18,
                    color: AppColors.gray500,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            width: 48,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primary100),
            ),
            child: const Icon(
              Icons.tune_rounded,
              size: 20,
              color: AppColors.primary600,
            ),
          ),
        ),
      ],
    );
  }
}
