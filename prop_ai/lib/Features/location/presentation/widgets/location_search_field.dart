import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/location_cubit.dart';

class LocationSearchField extends StatelessWidget {
  final LocationCubit cubit;

  const LocationSearchField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: cubit.updateSearchQuery,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search city, country or area',
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.gray500),
        suffixIcon: IconButton(
          onPressed: () {
            cubit.updateSearchQuery('');
          },
          icon: const Icon(Icons.close_rounded, color: AppColors.gray500),
        ),
        filled: true,
        fillColor: AppColors.gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary600, width: 1.5),
        ),
      ),
    );
  }
}
