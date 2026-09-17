import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeTopBar extends StatelessWidget {
  final String location;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAskAiTap;
  final VoidCallback? onProfileTap;

  const HomeTopBar({
    super.key,
    required this.location,
    this.onLocationTap,
    this.onNotificationTap,
    this.onAskAiTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: onLocationTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.primary600,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.semiBold12.copyWith(
                        color: AppColors.gray800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 14,
                    color: AppColors.gray500,
                  ),
                ],
              ),
            ),
          ),
        ),

        const Spacer(),

        _CircleButton(
          icon: Icons.notifications_none_rounded,
          showDot: true,
          onTap: onNotificationTap,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final bool showDot;
  final VoidCallback? onTap;

  const _CircleButton({required this.icon, required this.showDot, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          const SizedBox(width: 32, height: 32),
          Positioned(
            left: 2,
            top: 2,
            child: Icon(icon, size: 23, color: AppColors.gray700),
          ),
          if (showDot)
            Positioned(
              right: 1,
              top: 0,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.error500,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
