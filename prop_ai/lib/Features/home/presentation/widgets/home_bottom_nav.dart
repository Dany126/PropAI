import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

enum HomeNavItem { home, explore, favorites, assistant, profile }

class HomeBottomNav extends StatelessWidget {
  final HomeNavItem selected;
  final ValueChanged<HomeNavItem> onSelected;

  const HomeBottomNav({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.gray100)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Item(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
              item: HomeNavItem.home,
              selected: selected,
              onTap: onSelected,
            ),
            _Item(
              icon: Icons.explore_outlined,
              activeIcon: Icons.explore_rounded,
              label: 'Explore',
              item: HomeNavItem.explore,
              selected: selected,
              onTap: onSelected,
            ),
            _Item(
              icon: Icons.favorite_border_rounded,
              activeIcon: Icons.favorite_rounded,
              label: 'Favorites',
              item: HomeNavItem.favorites,
              selected: selected,
              onTap: onSelected,
            ),
            _Item(
              icon: Icons.auto_awesome_outlined,
              activeIcon: Icons.auto_awesome,
              label: 'Assistant',
              item: HomeNavItem.assistant,
              selected: selected,
              onTap: onSelected,
            ),
            _Item(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
              item: HomeNavItem.profile,
              selected: selected,
              onTap: onSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final HomeNavItem item;
  final HomeNavItem selected;
  final ValueChanged<HomeNavItem> onTap;

  const _Item({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = item == selected;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(item),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 21,
              color: isSelected ? AppColors.primary600 : AppColors.gray500,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.medium10.copyWith(
                color: isSelected ? AppColors.primary600 : AppColors.gray500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
