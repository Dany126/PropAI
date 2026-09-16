import 'package:flutter/widgets.dart';

/// PropAI Spacing System.
///
/// Base unit: 4px.
///
/// Mobile design target:
/// 414 x 896
///
/// Standard horizontal screen padding:
/// 20px
class AppSpacing {
  AppSpacing._();

  // ---------------------------------------------------------------------------
  // Base Scale
  // ---------------------------------------------------------------------------

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double huge = 48;

  // ---------------------------------------------------------------------------
  // Design System Specific
  // ---------------------------------------------------------------------------

  /// Standard horizontal screen padding.
  static const double screenPaddingH = 20;

  /// Standard vertical screen padding.
  static const double screenPaddingV = 24;

  /// Property/card internal padding.
  static const double cardPadding = 16;

  /// Gap between cards.
  static const double cardGap = 16;

  /// Gap between icon and text.
  static const double iconTextGap = 8;

  /// Gap between form fields.
  static const double formFieldGap = 12;

  /// Gap between major sections.
  static const double sectionGap = 24;

  /// Minimum touch target.
  static const double minTouchTarget = 44;

  /// Bottom navigation content height.
  static const double bottomNavigationHeight = 56;

  // ---------------------------------------------------------------------------
  // EdgeInsets
  // ---------------------------------------------------------------------------

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
    vertical: screenPaddingV,
  );

  static const EdgeInsets screenPaddingHOnly = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
  );

  static const EdgeInsets cardInsets = EdgeInsets.all(cardPadding);

  static const EdgeInsets buttonInsetsLg = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );

  static const EdgeInsets buttonInsetsMd = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static const EdgeInsets chipInsets = EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 4,
  );

  // ---------------------------------------------------------------------------
  // SizedBox Helpers
  // ---------------------------------------------------------------------------

  static const SizedBox gapXxs = SizedBox(
    width: xxs,
    height: xxs,
  );

  static const SizedBox gapXs = SizedBox(
    width: xs,
    height: xs,
  );

  static const SizedBox gapSm = SizedBox(
    width: sm,
    height: sm,
  );

  static const SizedBox gapMd = SizedBox(
    width: md,
    height: md,
  );

  static const SizedBox gapLg = SizedBox(
    width: lg,
    height: lg,
  );

  static const SizedBox gapXl = SizedBox(
    width: xl,
    height: xl,
  );

  static const SizedBox gapXxl = SizedBox(
    width: xxl,
    height: xxl,
  );

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