import 'package:flutter/material.dart';
import 'package:prop_ai/core/theme/theme.dart';
import 'package:prop_ai/core/utils/app_routes.dart';

import 'core/di/injection_container.dart';
import 'core/storage/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.init();

  await setupDependencies();

  runApp(const PropAI());
}

class PropAI extends StatelessWidget {
  const PropAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.splashView,
    );
  }
}
