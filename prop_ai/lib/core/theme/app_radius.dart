import 'package:flutter/material.dart';

/// PropAI Radius System
///
/// Corner-radius tokens matching the Component & Style Guide:
/// buttons/inputs 8-12px, cards 12-16px, bottom sheets 16px (top only),
/// chips/badges fully rounded (pill).
class AppRadius {
  AppRadius._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  // ---------------------------------------------------------------------
  // BorderRadius shortcuts
  // ---------------------------------------------------------------------
  static final BorderRadius button = BorderRadius.circular(sm);
  static final BorderRadius input = BorderRadius.circular(sm);
  static final BorderRadius card = BorderRadius.circular(md);
  static final BorderRadius cardLarge = BorderRadius.circular(lg);
  static final BorderRadius chip = BorderRadius.circular(pill);
  static final BorderRadius circular = BorderRadius.circular(pill);

  /// Bottom sheets / modals — rounded top corners only
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  /// Property card image — rounded top corners only (image sits above content)
  static const BorderRadius cardImageTop = BorderRadius.only(
    topLeft: Radius.circular(md),
    topRight: Radius.circular(md),
  );
}
