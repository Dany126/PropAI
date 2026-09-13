import 'package:flutter/material.dart';
import 'package:prop_ai/Features/auth/views/login_view.dart';
import 'package:prop_ai/Features/auth/views/widgets/auth_button.dart';
import 'package:prop_ai/core/theme/theme.dart';

class PasswordResetSuccessView extends StatelessWidget {
  const PasswordResetSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.success500.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 48,
                      color: AppColors.success500,
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  Text(
                    'Password reset successful',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold28.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.md),

                  Text(
                    'Your password has been successfully reset. You can now sign in using your new password.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular14.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  AuthButton(
                    text: 'Back to sign in',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginView()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
