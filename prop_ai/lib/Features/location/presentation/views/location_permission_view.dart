import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class LocationPermissionView extends StatelessWidget {
  final VoidCallback onCompleted;
  const LocationPermissionView({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Glowing Map Pin Icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.primary100.withValues(alpha: 0.8),
                            AppColors.primary50.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 48,
                      color: AppColors.primary600,
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome, // Substitute for sparkle
                          size: 16,
                          color: AppColors.aiAccent500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Text(
                  'Find properties near you',
                  style: AppTextStyle.bold24.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  'Allow location access so we can show\nrelevant properties and make area-based\nsearch easier.',
                  style: AppTextStyle.regular16.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.aiAccent50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.aiAccent100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.shield_outlined,
                        size: 16,
                        color: AppColors.aiAccent600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Your precise location is never shared',
                        style: AppTextStyle.medium12.copyWith(
                          color: AppColors.aiAccent600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      final isLoading = state.status == LocationStatus.loading;
                      return FilledButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                final cubit = context.read<LocationCubit>();
                                await cubit.useCurrentLocation();
                                if (!context.mounted) return;

                                final currentState = cubit.state;
                                if (currentState.status ==
                                    LocationStatus.success) {
                                  await cubit.saveSelectedLocation();
                                  if (!context.mounted) return;

                                  if (cubit.state.status ==
                                      LocationStatus.success) {
                                    onCompleted.call();
                                  }
                                }
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary600,
                          disabledBackgroundColor: AppColors.gray200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              )
                            : FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Get the current location automatically',
                                  style: AppTextStyle.bold16.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    context.read<LocationCubit>().proceedToSearch();
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Select  location manually',
                      style: AppTextStyle.bold16.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
