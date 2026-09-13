import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prop_ai/Features/splash/view/widgets/splash_logo.dart';
import 'package:prop_ai/core/theme/theme.dart';
import 'package:prop_ai/core/utils/app_routes.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 3), _goToOnboarding);
  }

  void _goToOnboarding() {
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, AppRoutes.onboardingView);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Center content
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The Logo
                const SplashLogo(),

                // PropAI text with blue dot
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PropAI',
                      style: AppTextStyle.bold44.copyWith(
                        color: AppColors.primary600,
                        letterSpacing: -1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, left: 4),
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.aiAccent500,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.sm),

                // Subtitle
                Text(
                  'Find your next home, intelligently.',
                  style: AppTextStyle.regular16.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Loader
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary100,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDot(AppColors.primary400),
                    const SizedBox(width: 6),
                    _buildDot(AppColors.primary400),
                    const SizedBox(width: 6),
                    _buildDot(AppColors.aiAccent500),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
