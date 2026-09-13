import 'package:flutter/material.dart';
import 'package:prop_ai/core/theme/theme.dart';

class OnboardingBottomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OnboardingBottomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary[600],
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.semiBold18.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
