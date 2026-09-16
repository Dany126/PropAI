import 'package:flutter/material.dart';

import 'app_colors.dart';

/// PropAI Shadow System.
///
/// The UI uses subtle, crisp shadows instead of heavy Material elevation.
class AppShadows {
  AppShadows._();

  // ---------------------------------------------------------------------------
  // Standard Card Shadow
  // ---------------------------------------------------------------------------

  /// Design token:
  /// 0px 1px 3px rgba(16, 24, 40, 0.10)
  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.10),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Icon Button
  // ---------------------------------------------------------------------------

  static List<BoxShadow> get iconButton => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.10),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Floating Elements
  // ---------------------------------------------------------------------------

  static List<BoxShadow> get floating => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.10),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Modal / Bottom Sheet
  // ---------------------------------------------------------------------------

  static List<BoxShadow> get modal => [
    BoxShadow(
      color: AppColors.gray900.withValues(alpha: 0.10),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  // ---------------------------------------------------------------------------
  // No Shadow
  // ---------------------------------------------------------------------------

  static const List<BoxShadow> none = [];
}
