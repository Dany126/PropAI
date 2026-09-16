import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// PropAI Global Theme.
///
/// Centralizes Flutter Material components around the PropAI design system.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      fontFamily: AppTextStyle.fontFamily,

      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary600,
        onPrimary: AppColors.white,

        secondary: AppColors.aiAccent600,
        onSecondary: AppColors.white,

        error: AppColors.error500,
        onError: AppColors.white,

        surface: AppColors.white,
        onSurface: AppColors.textPrimary,

        outline: AppColors.border,
      ),

      // =========================================================================
      // App Bar
      // =========================================================================
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: false,

        titleTextStyle: AppTextStyle.heading5.copyWith(
          color: AppColors.textPrimary,
        ),

        iconTheme: const IconThemeData(color: AppColors.gray700, size: 24),

        actionsIconTheme: const IconThemeData(
          color: AppColors.gray700,
          size: 24,
        ),
      ),

      // =========================================================================
      // Elevated Button
      // =========================================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary600,
          foregroundColor: AppColors.white,

          disabledBackgroundColor: AppColors.gray100,
          disabledForegroundColor: AppColors.gray400,

          minimumSize: const Size(0, 48),

          padding: AppSpacing.buttonInsetsLg,

          shape: RoundedRectangleBorder(borderRadius: AppRadius.button),

          textStyle: AppTextStyle.semiBold16.copyWith(color: AppColors.white),

          elevation: 0,

          shadowColor: Colors.transparent,

          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),

      // =========================================================================
      // Outlined Button
      // =========================================================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary600,

          minimumSize: const Size(0, 48),

          padding: AppSpacing.buttonInsetsLg,

          shape: RoundedRectangleBorder(borderRadius: AppRadius.button),

          side: const BorderSide(color: AppColors.primary600, width: 1),

          textStyle: AppTextStyle.semiBold16.copyWith(
            color: AppColors.primary600,
          ),

          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),

      // =========================================================================
      // Text Button
      // =========================================================================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary600,

          minimumSize: const Size(0, 44),

          padding: AppSpacing.buttonInsetsMd,

          textStyle: AppTextStyle.medium14.copyWith(
            color: AppColors.primary600,
          ),

          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),

      // =========================================================================
      // Text Fields
      // =========================================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: AppColors.gray50,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        hintStyle: AppTextStyle.regular14.copyWith(color: AppColors.gray400),

        labelStyle: AppTextStyle.medium14.copyWith(color: AppColors.gray700),

        floatingLabelStyle: AppTextStyle.medium14.copyWith(
          color: AppColors.primary600,
        ),

        errorStyle: AppTextStyle.regular12.copyWith(color: AppColors.error600),

        prefixIconColor: AppColors.gray500,

        suffixIconColor: AppColors.gray500,

        border: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: const BorderSide(color: AppColors.border),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: const BorderSide(color: AppColors.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: const BorderSide(color: AppColors.primary600, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: const BorderSide(color: AppColors.error500),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: const BorderSide(color: AppColors.error500, width: 1.5),
        ),
      ),

      // =========================================================================
      // Cards
      // =========================================================================
      cardTheme: CardThemeData(
        color: AppColors.surface,

        elevation: 0,

        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),

      // =========================================================================
      // Chips
      // =========================================================================
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray50,

        selectedColor: AppColors.primary100,

        disabledColor: AppColors.gray100,

        labelStyle: AppTextStyle.medium14.copyWith(color: AppColors.gray700),

        secondaryLabelStyle: AppTextStyle.medium14.copyWith(
          color: AppColors.primary700,
        ),

        side: const BorderSide(color: AppColors.gray200),

        shape: RoundedRectangleBorder(borderRadius: AppRadius.chip),

        padding: AppSpacing.chipInsets,

        showCheckmark: false,
      ),

      // =========================================================================
      // Checkbox
      // =========================================================================
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary600;
          }

          return AppColors.white;
        }),

        checkColor: WidgetStateProperty.all(AppColors.white),

        side: const BorderSide(color: AppColors.gray300, width: 1.5),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
      ),

      // =========================================================================
      // Radio
      // =========================================================================
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary600;
          }

          return AppColors.gray400;
        }),
      ),

      // =========================================================================
      // Switch
      // =========================================================================
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }

          return AppColors.gray400;
        }),

        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary600;
          }

          return AppColors.gray200;
        }),

        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // =========================================================================
      // Divider
      // =========================================================================
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // =========================================================================
      // Bottom Navigation
      // =========================================================================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,

        selectedItemColor: AppColors.primary600,

        unselectedItemColor: AppColors.gray400,

        selectedLabelStyle: AppTextStyle.semiBold12.copyWith(
          color: AppColors.primary600,
        ),

        unselectedLabelStyle: AppTextStyle.regular12.copyWith(
          color: AppColors.gray400,
        ),

        type: BottomNavigationBarType.fixed,

        elevation: 0,
      ),

      // =========================================================================
      // Navigation Bar - Material 3
      // =========================================================================
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,

        indicatorColor: AppColors.primary100,

        height: 56,

        elevation: 0,

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyle.semiBold12.copyWith(
              color: AppColors.primary600,
            );
          }

          return AppTextStyle.regular12.copyWith(color: AppColors.gray400);
        }),

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary600, size: 24);
          }

          return const IconThemeData(color: AppColors.gray400, size: 24);
        }),
      ),

      // =========================================================================
      // Bottom Sheet
      // =========================================================================
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,

        modalBackgroundColor: AppColors.white,

        elevation: 0,

        modalElevation: 0,

        shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),

        clipBehavior: Clip.antiAlias,
      ),

      // =========================================================================
      // Dialog
      // =========================================================================
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,

        elevation: 0,

        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardLarge),

        titleTextStyle: AppTextStyle.heading5.copyWith(
          color: AppColors.textPrimary,
        ),

        contentTextStyle: AppTextStyle.paragraph3.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // =========================================================================
      // Snackbar
      // =========================================================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray900,

        contentTextStyle: AppTextStyle.regular14.copyWith(
          color: AppColors.white,
        ),

        shape: RoundedRectangleBorder(borderRadius: AppRadius.input),

        behavior: SnackBarBehavior.floating,

        elevation: 0,

        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),

      // =========================================================================
      // Progress Indicator
      // =========================================================================
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary600,
        linearTrackColor: AppColors.primary100,
        circularTrackColor: AppColors.gray100,
      ),

      // =========================================================================
      // Icons
      // =========================================================================
      iconTheme: const IconThemeData(color: AppColors.gray600, size: 24),

      // =========================================================================
      // Splash / Interaction
      // =========================================================================
      splashFactory: InkRipple.splashFactory,

      splashColor: AppColors.primary100,

      highlightColor: AppColors.primary50,
    );
  }
}
