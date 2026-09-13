import 'package:flutter/material.dart';
import 'package:prop_ai/Features/on_boarding/model/onboarding_model.dart';
import 'package:prop_ai/Features/on_boarding/views/widgets/onboarding_bottom_button.dart';
import 'package:prop_ai/Features/on_boarding/views/widgets/onboarding_indicator.dart';
import 'package:prop_ai/Features/on_boarding/views/widgets/onboarding_page_item.dart';
import 'package:prop_ai/core/theme/theme.dart';
import 'package:prop_ai/core/utils/app_routes.dart';
import 'package:prop_ai/core/utils/assets.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final PageController _pageController;

  int _currentIndex = 0;

  final List<OnboardingModel> _pages = const [
    OnboardingModel(
      image: Assets.imagesOnBoardingOne,
      title: 'Find Your Perfect Home',
      description: 'Discover properties that match your lifestyle, preferences, and budget.',
    ),
    OnboardingModel(
      image: Assets.imagesOnBoardingTwo,
      title: 'Search Smarter with AI',
      description: 'Tell PropAI what you are looking for and let AI find the best matches for you.',
    ),
    OnboardingModel(
      image: Assets.imagesOnBoardingThree,
      title: 'Make Better Decisions',
      description: 'Get intelligent property insights and recommendations before you choose your next home.',
    ),
  ];

  bool get _isLastPage => _currentIndex == _pages.length - 1;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_isLastPage) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    Navigator.pushNamed(context, AppRoutes.loginView);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.centerRight,
                child: _isLastPage
                    ? const SizedBox.shrink()
                    : TextButton(
                        onPressed: _skip,
                        child: Text(
                          'Skip',
                          style: AppTextStyle.medium16.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPageItem(item: _pages[index]);
                },
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            OnboardingIndicator(
              currentIndex: _currentIndex,
              itemCount: _pages.length,
            ),

            const SizedBox(height: AppSpacing.xl),

            OnboardingBottomButton(
              text: _isLastPage ? 'Get Started' : 'Next',
              onPressed: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
