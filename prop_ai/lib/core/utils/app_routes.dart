import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prop_ai/Features/auth/views/forgot_password_view.dart';
import 'package:prop_ai/Features/auth/views/login_view.dart';
import 'package:prop_ai/Features/auth/views/signup_view.dart';
import 'package:prop_ai/Features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:prop_ai/Features/location/presentation/cubit/location_cubit.dart';
import 'package:prop_ai/Features/location/presentation/views/location_view.dart';
import 'package:prop_ai/Features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:prop_ai/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:prop_ai/Features/splash/view/splash_view.dart';
import 'package:prop_ai/core/di/injection_container.dart';
import 'package:prop_ai/Features/home/presentation/cubit/home_cubit.dart';
import 'package:prop_ai/Features/home/presentation/views/home_view.dart';
import 'package:prop_ai/Features/location/presentation/views/location_search_view.dart';
import 'package:prop_ai/Features/property/presentation/cubit/property_cubit.dart';
import 'package:prop_ai/Features/property/presentation/views/property_view.dart';

class AppRoutes {
  static const String splashView = '/splashView';
  static const String onboardingView = '/onboardingView';

  static const String loginView = '/loginView';
  static const String signupView = '/signupView';

  static const String forgotPasswordView = '/forgotPasswordView';
  static const String locationView = '/locationView';
  static const String locationSearchView = '/locationSearchView';

  static const String homeView = '/homeView';
  static const String propertyView = '/propertyView';
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
        return MaterialPageRoute(
          builder: (context) => LocationView(
            onCompleted: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeView,
                (route) => route.settings.name == AppRoutes.homeView,
              );
            },
          ),
        );

      case signupView:
        return MaterialPageRoute(builder: (context) => const SignupView());

      case forgotPasswordView:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),
        );
      case homeView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<HomeCubit>()..loadHome(),
            child: HomeView(
              onLocationTap: () {
                Navigator.pushNamed(context, AppRoutes.locationSearchView);
              },
              onAskAiTap: () {
                // AI Search feature will be connected here.
              },
              onFilterTap: () {
                // Filter feature will be connected here.
              },
              onPropertyTap: (String propertyId) {
                Navigator.pushNamed(context, AppRoutes.propertyView, arguments: propertyId);
              },
              onFavoriteTap: () {
                // Auth Gate will be connected here.
              },
              onNotificationTap: () {
                // Auth Gate will be connected here.
              },
              onProfileTap: () {
                // Auth Gate will be connected here.
              },
              onBottomNavTap: (item) {
                switch (item) {
                  case HomeNavItem.home:
                    break;

                  case HomeNavItem.explore:
                    // Explore feature.
                    break;

                  case HomeNavItem.favorites:
                    // Auth Gate.
                    break;

                  case HomeNavItem.assistant:
                    // AI Assistant feature.
                    break;

                  case HomeNavItem.profile:
                    // Auth Gate.
                    break;
                }
              },
            ),
          ),
        );

      case locationSearchView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<LocationCubit>()..loadSavedLocation(),
            child: LocationSearchView(
              onCompleted: () {
                Navigator.pop(context);
              },
            ),
          ),
        );

      case propertyView:
        final propertyId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<PropertyCubit>()..loadProperty(propertyId),
            child: PropertyView(
              propertyId: propertyId,

              onFavorite: () {
                // Auth Gate
              },

              onShare: () {
                // Share property
              },

              onRequestViewing: () {
                // Auth Gate
                // Then Request Viewing
              },
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Error'))),
        );
    }
  }
}
