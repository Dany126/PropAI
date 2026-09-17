import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PropertyTypeTabs extends StatelessWidget {
  final List<String> types;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const PropertyTypeTabs({
    super.key,
    required this.types,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary600 : AppColors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: selected ? AppColors.primary600 : AppColors.gray200,
                ),
              ),
              child: Text(
                types[index],
                style: AppTextStyle.medium12.copyWith(
                  color: selected ? AppColors.white : AppColors.gray600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
