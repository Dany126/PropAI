import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prop_ai/Features/auth/views/forgot_password_view.dart';
import 'package:prop_ai/Features/auth/views/login_view.dart';
import 'package:prop_ai/Features/auth/views/signup_view.dart';
import 'package:prop_ai/Features/location/presentation/views/location_view.dart';
import 'package:prop_ai/Features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:prop_ai/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:prop_ai/Features/splash/view/splash_view.dart';
import 'package:prop_ai/core/di/injection_container.dart';

class AppRoutes {
  static const String splashView = '/splashView';
  static const String onboardingView = '/onboardingView';

  static const String loginView = '/loginView';
  static const String signupView = '/signupView';

  static const String forgotPasswordView = '/forgotPasswordView';
  static const String locationView = '/locationView';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case onboardingView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<OnboardingCubit>(),
            child: const OnboardingView(),
          ),
        );

      case loginView:
        return MaterialPageRoute(builder: (context) => const LoginView());

      case locationView:
        return MaterialPageRoute(builder: (context) => const LocationView());

      case signupView:
        return MaterialPageRoute(builder: (context) => const SignupView());

      case forgotPasswordView:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Error'))),
        );
    }
  }
}
