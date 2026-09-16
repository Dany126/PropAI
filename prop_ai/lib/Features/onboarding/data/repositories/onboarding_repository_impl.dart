import '../../domain/entities/onboarding_page.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  List<OnboardingPage> getPages() {
    return localDataSource.getPages();
  }

  @override
  Future<void> completeOnboarding() {
    return localDataSource.completeOnboarding();
  }
}
