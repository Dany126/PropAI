import 'package:flutter/material.dart';

import 'app_colors.dart';

/// PropAI Shadow / Elevation System
///
/// Soft, gray-tinted shadows — low opacity, no harsh drop shadows.
/// Use [card] for property cards, [floating] for FABs/floating buttons,
/// [modal] for bottom sheets and dialogs, [iconButton] for circular
/// top-bar icon buttons (notification bell, chat icon, map back button).
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get iconButton => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get floating => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.12),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get modal => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.16),
      blurRadius: 24,
      offset: const Offset(0, -4),
    ),
  ];

  /// No shadow — used for flat elements like buttons/inputs
  static const List<BoxShadow> none = [];
}
