import 'package:flutter/material.dart';

/// PropAI Radius System.
class AppRadius {
  AppRadius._();

  // ---------------------------------------------------------------------------
  // Radius Tokens
  // ---------------------------------------------------------------------------

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 14;
  static const double xl = 20;
  static const double xxl = 24;
  static const double pill = 999;

  // ---------------------------------------------------------------------------
  // Component Radius
  // ---------------------------------------------------------------------------

  /// Buttons — 12px
  static final BorderRadius button = BorderRadius.circular(12);

  /// Inputs — 12px
  static final BorderRadius input = BorderRadius.circular(12);

  /// Cards — 14px
  static final BorderRadius card = BorderRadius.circular(14);

  /// Large cards — 20px
  static final BorderRadius cardLarge = BorderRadius.circular(20);

  /// Chips / badges — pill
  static final BorderRadius chip = BorderRadius.circular(pill);

  /// Circular elements
  static final BorderRadius circular = BorderRadius.circular(pill);

  /// Bottom sheets — 20px top corners
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  );

  /// Property image inside card.
  static const BorderRadius cardImageTop = BorderRadius.only(
    topLeft: Radius.circular(14),
    topRight: Radius.circular(14),
  );

  /// Small image radius.
  static final BorderRadius image = BorderRadius.circular(12);
}