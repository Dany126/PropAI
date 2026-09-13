import 'package:flutter/material.dart';
import 'app_colors.dart';

/// PropAI Typography System
///
/// Font family: Inter. Add the Inter font files under
/// `assets/fonts/` and register them in pubspec.yaml, e.g.:
///
/// fonts:
///   - family: Inter
///     fonts:
///       - asset: assets/fonts/Inter-Regular.ttf
///         weight: 400
///       - asset: assets/fonts/Inter-Medium.ttf
///         weight: 500
///       - asset: assets/fonts/Inter-SemiBold.ttf
///         weight: 600
///       - asset: assets/fonts/Inter-Bold.ttf
///         weight: 700
///
/// Usage convention:
/// - Display1/2   -> marketing/splash only (rare)
/// - Heading1-3   -> screen titles
/// - Heading4-5   -> section headers, card titles
/// - Paragraph1-4 -> body text, decreasing emphasis
/// - Label1-5     -> buttons, chips, tags, badges
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';

  // ---------------------------------------------------------------------
  // Base builder
  // ---------------------------------------------------------------------
  static TextStyle _base({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ---------------------------------------------------------------------
  // Display — 72 / 60 (rare, marketing/splash)
  // ---------------------------------------------------------------------
  static TextStyle display1Regular({Color? color}) =>
      _base(size: 72, weight: FontWeight.w400, color: color ?? AppColors.textPrimary);
  static TextStyle display1Bold({Color? color}) =>
      _base(size: 72, weight: FontWeight.w700, color: color ?? AppColors.textPrimary);

  static TextStyle display2Regular({Color? color}) =>
      _base(size: 60, weight: FontWeight.w400, color: color ?? AppColors.textPrimary);
  static TextStyle display2Bold({Color? color}) =>
      _base(size: 60, weight: FontWeight.w700, color: color ?? AppColors.textPrimary);

  // ---------------------------------------------------------------------
  // Headings — 44 / 36 / 28 / 24 / 20
  // ---------------------------------------------------------------------
  static TextStyle heading1({Color? color, FontWeight weight = FontWeight.w700}) =>
      _base(size: 44, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle heading2({Color? color, FontWeight weight = FontWeight.w700}) =>
      _base(size: 36, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle heading3({Color? color, FontWeight weight = FontWeight.w700}) =>
      _base(size: 28, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle heading4({Color? color, FontWeight weight = FontWeight.w700}) =>
      _base(size: 24, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle heading5({Color? color, FontWeight weight = FontWeight.w700}) =>
      _base(size: 20, weight: weight, color: color ?? AppColors.textPrimary);

  // ---------------------------------------------------------------------
  // Paragraph — 18 / 16 / 14 / 12
  // ---------------------------------------------------------------------
  static TextStyle paragraph1({Color? color, FontWeight weight = FontWeight.w400}) =>
      _base(size: 18, weight: weight, color: color ?? AppColors.textPrimary, height: 1.5);

  static TextStyle paragraph2({Color? color, FontWeight weight = FontWeight.w400}) =>
      _base(size: 16, weight: weight, color: color ?? AppColors.textSecondary, height: 1.5);

  static TextStyle paragraph3({Color? color, FontWeight weight = FontWeight.w400}) =>
      _base(size: 14, weight: weight, color: color ?? AppColors.textSecondary, height: 1.4);

  static TextStyle paragraph4({Color? color, FontWeight weight = FontWeight.w400}) =>
      _base(size: 12, weight: weight, color: color ?? AppColors.textMuted, height: 1.4);

  // ---------------------------------------------------------------------
  // Label — 18 / 16 / 14 / 12 / 10 (buttons, chips, tags, badges)
  // ---------------------------------------------------------------------
  static TextStyle label1({Color? color, FontWeight weight = FontWeight.w600}) =>
      _base(size: 18, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle label2({Color? color, FontWeight weight = FontWeight.w600}) =>
      _base(size: 16, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle label3({Color? color, FontWeight weight = FontWeight.w500}) =>
      _base(size: 14, weight: weight, color: color ?? AppColors.textPrimary);

  static TextStyle label4({Color? color, FontWeight weight = FontWeight.w500}) =>
      _base(size: 12, weight: weight, color: color ?? AppColors.textSecondary);

  static TextStyle label5({Color? color, FontWeight weight = FontWeight.w500}) =>
      _base(size: 10, weight: weight, color: color ?? AppColors.textMuted);

  // ---------------------------------------------------------------------
  // Common semantic shortcuts (used directly in widgets)
  // ---------------------------------------------------------------------

  /// Screen top-bar / card section titles
  static TextStyle get sectionTitle => heading5(color: AppColors.gray900);

  /// Property card price
  static TextStyle get propertyPrice => label1(color: AppColors.gray900, weight: FontWeight.w700);

  /// Property card title
  static TextStyle get propertyTitle => label2(color: AppColors.gray900, weight: FontWeight.w600);

  /// Property card location / meta text
  static TextStyle get propertyMeta => paragraph4(color: AppColors.gray500);

  /// Primary button label
  static TextStyle get buttonPrimary => label1(color: AppColors.white, weight: FontWeight.w600);

  /// Secondary/tertiary button label
  static TextStyle get buttonSecondary => label2(color: AppColors.primary600, weight: FontWeight.w600);

  /// Input field label
  static TextStyle get inputLabel => label3(color: AppColors.gray700);

  /// Input placeholder
  static TextStyle get inputPlaceholder => paragraph3(color: AppColors.gray400);

  /// Error/helper text under inputs
  static TextStyle get helperError => paragraph4(color: AppColors.error600);

  /// AI surface body text (assistant chat, AI search)
  static TextStyle get aiBody => paragraph2(color: AppColors.gray900);
}
