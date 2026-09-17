import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  final bool ai;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
    this.ai = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.bold18.copyWith(color: AppColors.gray900),
            ),

            if (subtitle != null) ...[
              const SizedBox(height: 3),
              Row(
                spacing: 5,
                children: [
                  if (ai) ...[
                    const Icon(
                      Icons.auto_awesome,
                      size: 17,
                      color: AppColors.aiAccent600,
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    subtitle!,
                    style: AppTextStyle.regular12.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See all',
              style: AppTextStyle.semiBold12.copyWith(
                color: AppColors.primary600,
              ),
            ),
          ),
      ],
    );
  }
}
