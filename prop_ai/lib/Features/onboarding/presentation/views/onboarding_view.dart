import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../location/presentation/views/location_view.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_navigation.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  Future<void> _finish(BuildContext context) async {
    await context.read<OnboardingCubit>().complete();

    if (!context.mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LocationView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state.pages.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: state.pages.length,
                    onPageChanged: context.read<OnboardingCubit>().changePage,
                    itemBuilder: (context, index) {
                      return OnboardingContent(
                        page: state.pages[index],
                        skipAction: () {
                          _finish(context);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
                  child: Column(
                    children: [
                      OnboardingIndicator(
                        currentIndex: state.currentPage,
                        count: state.pages.length,
                      ),
                      const SizedBox(height: 22),
                      OnboardingNavigation(
                        isLastPage: state.currentPage == state.pages.length - 1,

                        onNext: () {
                          if (state.currentPage == state.pages.length - 1) {
                            _finish(context);
                            return;
                          }

                          context.read<OnboardingCubit>().changePage(
                            state.currentPage + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
