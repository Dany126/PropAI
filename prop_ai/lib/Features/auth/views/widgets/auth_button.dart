import 'package:flutter/material.dart';
import 'package:prop_ai/core/theme/theme.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.logo,
  });
  final String? logo;

  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              if (logo != null) Image.asset(logo!, width: 20, height: 20),
              const SizedBox(width: 8),
              Text(
                text,

                style: AppTextStyle.semiBold16.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary600,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            if (logo != null) Image.asset(logo!, width: 20, height: 20),
            Text(
              text,
              style: AppTextStyle.semiBold16.copyWith(color: AppColors.white),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
