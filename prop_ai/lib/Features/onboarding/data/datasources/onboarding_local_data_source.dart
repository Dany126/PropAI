import 'package:prop_ai/core/utils/assets.dart';

import '../../../../core/storage/app_preferences.dart';
import '../../domain/entities/onboarding_page.dart';

abstract class OnboardingLocalDataSource {
  List<OnboardingPage> getPages();

  Future<void> completeOnboarding();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  List<OnboardingPage> getPages() {
    return const [
      OnboardingPage(
        image: Assets.imagesOnBoardingOne,
        title: 'Find Your Perfect Place',
        description: 'Discover properties that match your lifestyle, preferences, and budget.',
        hasSkipButton: true,
      ),
      OnboardingPage(
        image: Assets.imagesOnBoardingTwo,
        title: 'Explore Properties Your Way',
        description: 'Browse beautiful homes, apartments, and villas using a simple and intuitive experience.',
        hasSkipButton: true,
      ),
      OnboardingPage(
        image: Assets.imagesOnBoardingThree,
        title: 'Make Better Decisions',
        description: 'Compare properties, explore locations, and find the place that feels right for you.',
        hasSkipButton: false,
      ),
    ];
  }

  @override
  Future<void> completeOnboarding() async {
    await AppPreferences.setOnboardingCompleted(true);
  }
}
