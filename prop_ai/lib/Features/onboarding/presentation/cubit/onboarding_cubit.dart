import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/onboarding_repository.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  OnboardingCubit({required this.repository})
    : super(OnboardingState(pages: repository.getPages()));

  void changePage(int index) {
    

    if (index < 0 || index >= state.pages.length) {
      return;
    }

    emit(state.copyWith(currentPage: index));
  }

  Future<void> complete() async {
    emit(state.copyWith(isCompleting: true));

    await repository.completeOnboarding();

    emit(state.copyWith(isCompleting: false));
  }

  bool get isLastPage {
    return state.currentPage == state.pages.length - 1;
  }
}
