import '../entities/onboarding_page.dart';

abstract class OnboardingRepository {
  List<OnboardingPage> getPages();

  Future<void> completeOnboarding();
}
