import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AgentCard extends StatelessWidget {
  final String name;

  const AgentCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary100),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'EM',
              style: AppTextStyle.semiBold12.copyWith(
                color: AppColors.primary600,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.semiBold12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.verified, size: 14, color: AppColors.primary600),
                  ],
                ),

                const SizedBox(height: 3),

                Text(
                  'Available for guided private tours & keys',
                  style: AppTextStyle.regular12.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary100),
            ),
            child: Text(
              'Instant\nSync',
              textAlign: TextAlign.center,
              style: AppTextStyle.semiBold10.copyWith(
                color: AppColors.primary600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
