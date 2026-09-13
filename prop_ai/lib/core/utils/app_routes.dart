import 'package:flutter/material.dart';
import 'package:prop_ai/Features/on_boarding/views/onboarding_view.dart';
import 'package:prop_ai/Features/splash/view/splash_view.dart';

class AppRoutes {
  static const String splashView = '/splashView';
  static const String onboardingView = '/onboardingView';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case onboardingView:
        return MaterialPageRoute(builder: (context) => const OnboardingView());

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Error'))),
        );
    }
  }
}
