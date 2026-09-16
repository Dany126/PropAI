/// App-wide non-visual constants (durations, sizes, limits).
/// Keep visual tokens (color/typography/spacing) in `core/theme/` —
/// this file is for behavioral/config constants only.
class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------
  // App Info
  // ---------------------------------------------------------------------

  // ---------------------------------------------------------------------
  // Animation Durations
  // ---------------------------------------------------------------------
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 250);
  static const Duration animationSlow = Duration(milliseconds: 400);
  static const Duration skeletonShimmerDuration = Duration(milliseconds: 1200);

  // ---------------------------------------------------------------------
  // Component Sizes
  // ---------------------------------------------------------------------
  static const double buttonHeightSm = 32;
  static const double buttonHeightMd = 40;
  static const double buttonHeightLg = 48;
  static const double buttonHeightXl = 56;

  static const double iconSizeInline = 20;
  static const double iconSizeStandalone = 24;
  static const double avatarSizeSm = 32;
  static const double avatarSizeMd = 48;
  static const double avatarSizeLg = 96;

  static const double minTouchTarget = 44;

  // ---------------------------------------------------------------------
  // Pagination / Lists
  // ---------------------------------------------------------------------
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // ---------------------------------------------------------------------
  // OTP / Auth
  // ---------------------------------------------------------------------
  static const int otpLength = 6;
  static const Duration otpResendCooldown = Duration(seconds: 45);
  static const Duration sessionTokenRefreshBuffer = Duration(minutes: 2);

  // ---------------------------------------------------------------------
  // AI / Search
  // ---------------------------------------------------------------------
  static const int aiSearchDebounceMs = 400;
  static const int minQueryLengthForAiSearch = 3;
  static const double semanticSearchMinSimilarity = 0.65;

  // ---------------------------------------------------------------------
  //   App Info
  //---------------------------------------------------------------------
  static const String appName = 'PropAI';
  static const String appTagline = 'Find your next home, intelligently.';

  static const String onboardingKey = 'onboarding_completed';
  static const String locationSelectedKey = 'location_selected';
  static const String locationNameKey = 'location_name';
  static const String authenticatedKey = 'authenticated';

  static const String defaultLocation = 'Dubai, UAE';
}
