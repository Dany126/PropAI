import 'package:equatable/equatable.dart';

import '../../domain/entities/onboarding_page.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final List<OnboardingPage> pages;
  final bool isCompleting;

  const OnboardingState({
    this.currentPage = 0,
    this.pages = const [],
    this.isCompleting = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingPage>? pages,
    bool? isCompleting,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
      isCompleting: isCompleting ?? this.isCompleting,
    );
  }

  @override
  List<Object?> get props => [currentPage, pages, isCompleting];
}
