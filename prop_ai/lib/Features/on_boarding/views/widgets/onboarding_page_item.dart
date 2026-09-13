import 'package:flutter/material.dart';
import 'package:prop_ai/Features/on_boarding/model/onboarding_model.dart';
import 'package:prop_ai/core/theme/theme.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel item;

  const OnboardingPageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Image.asset(
              item.image,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold24.copyWith(color: AppColors.gray900),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular16.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
