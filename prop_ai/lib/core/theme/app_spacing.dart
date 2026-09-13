import 'package:flutter/widgets.dart';

/// PropAI Spacing System
///
/// Base unit: 4px. Use these tokens instead of hardcoded numbers so
/// spacing stays consistent across the app.
class AppSpacing {
  AppSpacing._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double huge = 48;

  // ---------------------------------------------------------------------
  // Common semantic spacing shortcuts
  // ---------------------------------------------------------------------

  /// Standard screen horizontal padding
  static const double screenPaddingH = lg;

  /// Standard screen top/bottom margin
  static const double screenPaddingV = xxl;

  /// Internal card padding
  static const double cardPadding = md;

  /// Gap between stacked cards in a list
  static const double cardGap = lg;

  /// Gap between an icon and adjacent text
  static const double iconTextGap = xs;

  /// Gap between form fields
  static const double formFieldGap = md;

  /// Gap between major page sections (e.g. "Recommended" -> "Nearby")
  static const double sectionGap = xl;

  // ---------------------------------------------------------------------
  // Convenience EdgeInsets
  // ---------------------------------------------------------------------
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
    vertical: screenPaddingV,
  );

  static const EdgeInsets screenPaddingHOnly = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
  );

  static const EdgeInsets cardInsets = EdgeInsets.all(cardPadding);

  static const EdgeInsets buttonInsetsLg = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: md,
  );

  static const EdgeInsets buttonInsetsMd = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: sm,
  );

  static const EdgeInsets chipInsets = EdgeInsets.symmetric(
    horizontal: sm,
    vertical: xs,
  );

  // ---------------------------------------------------------------------
  // SizedBox helpers — common vertical/horizontal gaps
  // ---------------------------------------------------------------------
  static const SizedBox gapXxs = SizedBox(width: xxs, height: xxs);
  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);
  static const SizedBox gapXxl = SizedBox(width: xxl, height: xxl);

  static const SizedBox vGapXs = SizedBox(height: xs);
  static const SizedBox vGapSm = SizedBox(height: sm);
  static const SizedBox vGapMd = SizedBox(height: md);
  static const SizedBox vGapLg = SizedBox(height: lg);
  static const SizedBox vGapXl = SizedBox(height: xl);
  static const SizedBox vGapXxl = SizedBox(height: xxl);

  static const SizedBox hGapXs = SizedBox(width: xs);
  static const SizedBox hGapSm = SizedBox(width: sm);
  static const SizedBox hGapMd = SizedBox(width: md);
  static const SizedBox hGapLg = SizedBox(width: lg);
  static const SizedBox hGapXl = SizedBox(width: xl);
}
