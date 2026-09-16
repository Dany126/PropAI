import 'package:flutter/material.dart';
import 'package:prop_ai/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingNavigation extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingNavigation({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary600,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Text(
                  isLastPage ? 'Get Started' : 'Next',
                  style: AppTextStyle.semiBold16.copyWith(
                    color: AppColors.white,
                  ),
                ),
                if (!isLastPage) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
