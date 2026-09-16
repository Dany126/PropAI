import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where are you looking?',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.gray900),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose a location to discover properties around you.',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.gray600, height: 1.5),
        ),
      ],
    );
  }
}
