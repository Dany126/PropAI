import 'package:flutter/material.dart';

/// PropAI Color System
///
/// Source of truth for every color used in the app. Derived from the
/// Housely design-system reference tokens, extended with a dedicated
/// AI-accent (teal) scale for PropAI's AI-powered surfaces.
///
/// Color role rules (see Component & Style Guide for full detail):
/// - [primary]  -> navigation, standard CRUD/booking actions
/// - [warning]  -> promotions only, never functional UI
/// - [aiAccent] -> AI Search, Semantic Search, AI Assistant — ONLY
/// - [error]    -> destructive actions, validation, favorited heart
/// - [success]  -> confirmations, booking success
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------
  // Base
  // ---------------------------------------------------------------------
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF0B1327);

  // ---------------------------------------------------------------------
  // Primary — Violet
  // Usage: navigation, primary buttons, active states, standard actions
  // ---------------------------------------------------------------------
  static const Color primary25 = Color(0xFFFCFAFF);
  static const Color primary50 = Color(0xFFF9F5FF);
  static const Color primary100 = Color(0xFFF4EBFF);
  static const Color primary200 = Color(0xFFE9D7FE);
  static const Color primary300 = Color(0xFFD6BBFB);
  static const Color primary400 = Color(0xFFB692F6);
  static const Color primary500 = Color(0xFF9E77ED); // main
  static const Color primary600 = Color(0xFF7F56D9); // primary action
  static const Color primary700 = Color(0xFF6941C6);
  static const Color primary800 = Color(0xFF53389E);
  static const Color primary900 = Color(0xFF42307D);

  /// Convenience map for programmatic access, e.g. AppColors.primary[600]
  static const Map<int, Color> primary = {
    25: primary25,
    50: primary50,
    100: primary100,
    200: primary200,
    300: primary300,
    400: primary400,
    500: primary500,
    600: primary600,
    700: primary700,
    800: primary800,
    900: primary900,
  };

  // ---------------------------------------------------------------------
  // Gray — Neutral
  // Usage: text, borders, backgrounds, dividers, icons
  // ---------------------------------------------------------------------
  static const Color gray25 = Color(0xFFFCFCFC);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF2F4F7);
  static const Color gray200 = Color(0xFFEAECF0);
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray400 = Color(0xFF98A2B3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray600 = Color(0xFF475467);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray800 = Color(0xFF1D2939);
  static const Color gray900 = Color(0xFF101828);

  static const Map<int, Color> gray = {
    25: gray25,
    50: gray50,
    100: gray100,
    200: gray200,
    300: gray300,
    400: gray400,
    500: gray500,
    600: gray600,
    700: gray700,
    800: gray800,
    900: gray900,
  };

  // ---------------------------------------------------------------------
  // Error — Red
  // Usage: validation errors, destructive actions, favorited heart icon
  // ---------------------------------------------------------------------
  static const Color error25 = Color(0xFFFFFBFA);
  static const Color error50 = Color(0xFFFEF3F2);
  static const Color error100 = Color(0xFFFEE4E2);
  static const Color error200 = Color(0xFFFECDCA);
  static const Color error300 = Color(0xFFFDA29B);
  static const Color error400 = Color(0xFFF97066);
  static const Color error500 = Color(0xFFF04438); // main
  static const Color error600 = Color(0xFFD92D20);
  static const Color error700 = Color(0xFFB42318);
  static const Color error800 = Color(0xFF912018);
  static const Color error900 = Color(0xFF7A271A);

  static const Map<int, Color> error = {
    25: error25,
    50: error50,
    100: error100,
    200: error200,
    300: error300,
    400: error400,
    500: error500,
    600: error600,
    700: error700,
    800: error800,
    900: error900,
  };

  // ---------------------------------------------------------------------
  // Success — Green
  // Usage: confirmations, booking success, valid form states
  // ---------------------------------------------------------------------
  static const Color success25 = Color(0xFFF6FEF9);
  static const Color success50 = Color(0xFFECFDF3);
  static const Color success100 = Color(0xFFD1FADF);
  static const Color success200 = Color(0xFFA6F4C5);
  static const Color success300 = Color(0xFF6CE9A6);
  static const Color success400 = Color(0xFF32D583);
  static const Color success500 = Color(0xFF12B76A); // main
  static const Color success600 = Color(0xFF039855);
  static const Color success700 = Color(0xFF027A48);
  static const Color success800 = Color(0xFF05603A);
  static const Color success900 = Color(0xFF054F31);

  static const Map<int, Color> success = {
    25: success25,
    50: success50,
    100: success100,
    200: success200,
    300: success300,
    400: success400,
    500: success500,
    600: success600,
    700: success700,
    800: success800,
    900: success900,
  };

  // ---------------------------------------------------------------------
  // Warning — Orange/Yellow
  // Usage: promo banners, alerts ONLY — never functional/AI UI
  // ---------------------------------------------------------------------
  static const Color warning25 = Color(0xFFF6FEF9);
  static const Color warning50 = Color(0xFFFFFAEB);
  static const Color warning100 = Color(0xFFFEF0C7);
  static const Color warning200 = Color(0xFFFEDF89);
  static const Color warning300 = Color(0xFFFEC84B);
  static const Color warning400 = Color(0xFFFDB022);
  static const Color warning500 = Color(0xFFF79009); // main
  static const Color warning600 = Color(0xFFDC6803);
  static const Color warning700 = Color(0xFFB54708);
  static const Color warning800 = Color(0xFF93370D);
  static const Color warning900 = Color(0xFF7A2E0E);

  static const Map<int, Color> warning = {
    25: warning25,
    50: warning50,
    100: warning100,
    200: warning200,
    300: warning300,
    400: warning400,
    500: warning500,
    600: warning600,
    700: warning700,
    800: warning800,
    900: warning900,
  };

  // ---------------------------------------------------------------------
  // AI Accent — Teal/Cyan (PropAI-specific)
  // Usage: EXCLUSIVELY for AI Search, Semantic Search, AI Assistant.
  // Never use for standard navigation or promo content — this is the
  // visual signal that tells the user "this is an AI-powered feature."
  // ---------------------------------------------------------------------
  static const Color aiAccent50 = Color(0xFFF0F9FF);
  static const Color aiAccent100 = Color(0xFFE0F2FE);
  static const Color aiAccent500 = Color(0xFF0BA5EC); // main
  static const Color aiAccent600 = Color(0xFF0086C9); // action
  static const Color aiAccent700 = Color(0xFF026AA2);

  static const Map<int, Color> aiAccent = {
    50: aiAccent50,
    100: aiAccent100,
    500: aiAccent500,
    600: aiAccent600,
    700: aiAccent700,
  };

  // ---------------------------------------------------------------------
  // Semantic aliases — use these in widgets instead of raw scale values
  // where possible, so future re-theming only touches this file.
  // ---------------------------------------------------------------------
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textMuted = gray500;
  static const Color textDisabled = gray400;
  static const Color textOnPrimary = white;

  static const Color background = white;
  static const Color surface = white;
  static const Color surfaceMuted = gray50;

  static const Color border = gray200;
  static const Color borderFocused = primary500;
  static const Color divider = gray100;

  static const Color favoriteActive = error500;
  static const Color favoriteInactive = gray400;

  static const Color ratingStar = warning500;
}
