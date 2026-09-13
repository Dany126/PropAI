import 'package:flutter/material.dart';
import 'package:prop_ai/core/utils/assets.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesLogo,
      width: 120,
      height: 120,
      fit: BoxFit.contain,
    );
  }
}
