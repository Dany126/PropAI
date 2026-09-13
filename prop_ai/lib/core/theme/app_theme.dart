import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// PropAI App Theme
///
/// Wires the design tokens (colors, typography, spacing, radius) into a
/// single Flutter [ThemeData] used at the MaterialApp root:
///
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light,
///   ...
/// )
/// ```
///
/// Prefer using AppColors / AppTextStyle / AppSpacing / AppRadius
/// directly in widgets for anything not covered by a global theme
/// property (e.g. property card styling), so behavior stays explicit
/// and traceable to the Style Guide.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTextStyle.fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      brightness: Brightness.light,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary500,
        primary: AppColors.primary600,
        onPrimary: AppColors.white,
        secondary: AppColors.aiAccent600,
        onSecondary: AppColors.white,
        error: AppColors.error500,
        onError: AppColors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        brightness: Brightness.light,
      ),

      // -------------------------------------------------------------
      // AppBar
      // -------------------------------------------------------------
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.gray900,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyle.bold20.copyWith(color: AppColors.gray900),
        iconTheme: const IconThemeData(color: AppColors.gray700),
      ),

      // -------------------------------------------------------------
      // Elevated (Primary) Button
      // -------------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary600,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.gray100,
          disabledForegroundColor: AppColors.gray400,
          minimumSize: const Size.fromHeight(48), // Lg size
          padding: AppSpacing.buttonInsetsLg,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
          textStyle: AppTextStyle.semiBold18.copyWith(color: AppColors.white),
          elevation: 0,
        ),
      ),

      // -------------------------------------------------------------
      // Outlined (Secondary) Button
      // -------------------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary600,
          side: const BorderSide(color: AppColors.primary600, width: 1),
          minimumSize: const Size.fromHeight(48),
          padding: AppSpacing.buttonInsetsLg,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.button),
          textStyle: AppTextStyle.semiBold16.copyWith(color: AppColors.primary600),
        ),
      ),

      // -------------------------------------------------------------
      // Text (Tertiary) Button
      // -------------------------------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary600,
          padding: AppSpacing.buttonInsetsMd,
          textStyle: AppTextStyle.medium14.copyWith(color: AppColors.primary600),
        ),
      ),

      // -------------------------------------------------------------
      // Text Input
      // -------------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTextStyle.regular14.copyWith(color: AppColors.gray400),
        labelStyle: AppTextStyle.medium14.copyWith(color: AppColors.gray700),
        errorStyle: AppTextStyle.regular12.copyWith(color: AppColors.error600),
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
          borderSide: const BorderSide(color: AppColors.borderFocused, width: 1.5),
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

      // -------------------------------------------------------------
      // Cards
      // -------------------------------------------------------------
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0, // shadows applied manually via AppShadows for full control
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),

      // -------------------------------------------------------------
      // Chips
      // -------------------------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray50,
        selectedColor: AppColors.primary50,
        disabledColor: AppColors.gray100,
        labelStyle: AppTextStyle.medium14.copyWith(color: AppColors.gray700),
        secondaryLabelStyle: AppTextStyle.medium14.copyWith(color: AppColors.primary700),
        side: const BorderSide(color: AppColors.gray200),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.chip),
        padding: AppSpacing.chipInsets,
      ),

      // -------------------------------------------------------------
      // Checkbox
      // -------------------------------------------------------------
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary600;
          }
          return AppColors.white;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.gray300, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xs)),
      ),

      // -------------------------------------------------------------
      // Divider
      // -------------------------------------------------------------
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // -------------------------------------------------------------
      // Bottom Navigation
      // -------------------------------------------------------------
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary600,
        unselectedItemColor: AppColors.gray400,
        selectedLabelStyle: AppTextStyle.medium12.copyWith(color: AppColors.primary600),
        unselectedLabelStyle: AppTextStyle.medium12.copyWith(color: AppColors.gray400),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // -------------------------------------------------------------
      // Bottom Sheet
      // -------------------------------------------------------------
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
        modalElevation: 0,
      ),

      // -------------------------------------------------------------
      // Snackbar
      // -------------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray900,
        contentTextStyle: AppTextStyle.regular14.copyWith(color: AppColors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        behavior: SnackBarBehavior.floating,
      ),

      // -------------------------------------------------------------
      // Icons
      // -------------------------------------------------------------
      iconTheme: const IconThemeData(color: AppColors.gray600, size: 24),
    );
  }
}
