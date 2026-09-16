import 'package:equatable/equatable.dart';

class OnboardingPage extends Equatable {
  final String image;
  final String title;
  final String description;
  final bool hasSkipButton;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.hasSkipButton,
  });

  @override
  List<Object?> get props => [image, title, description];
}
