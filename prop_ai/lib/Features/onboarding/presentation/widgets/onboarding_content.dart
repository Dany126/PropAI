import 'package:flutter/material.dart';
import 'package:prop_ai/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/onboarding_page.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    page.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return Container(
                        color: AppColors.gray100,
                        child: const Icon(
                          Icons.home_outlined,
                          size: 80,
                          color: AppColors.gray400,
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: page.hasSkipButton,
                  child: Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Skip',
                        style: AppTextStyle.semiBold14.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(page.title, style: AppTextStyle.semiBold20),
                const SizedBox(height: 14),
                Text(
                  page.description,
                  style: AppTextStyle.regular16.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
