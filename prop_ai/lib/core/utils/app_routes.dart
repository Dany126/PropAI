import 'package:flutter/material.dart';
import 'package:prop_ai/Features/splash/view/splash_view.dart';

class AppRoutes {
  static const String splashView = '/splashView';
  

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (context) => const SplashView());

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Error'))),
        );
    }
  }
}
