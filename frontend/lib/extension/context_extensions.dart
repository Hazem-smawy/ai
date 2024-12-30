// Define screen breakpoints as constants
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

const double smallWidth = 500.0;
const double mediumWidth = 768.0;
const double largeWidth = 1024.0;

extension BuildContextExtension on BuildContext {
  // Screen size categories
  bool get isExtraSmall => size.width <= smallWidth;
  bool get isSmall => size.width > smallWidth && size.width < mediumWidth;
  bool get isMedium => size.width >= mediumWidth && size.width < largeWidth;
  bool get isLarge => size.width >= largeWidth;

  // Screen dimensions
  Size get size => MediaQuery.of(this).size;

  // Text styles with fallback values
  TextStyle get displayLarge => AppTextStyle.displayLarge;
  TextStyle get displayMedium => AppTextStyle.displayMedium;
  TextStyle get displaySmall => AppTextStyle.displaySmall;

  TextStyle get titleLarge => AppTextStyle.titleLarge;
  TextStyle get titleMedium => AppTextStyle.titleMedium;
  TextStyle get titleSmall => AppTextStyle.titleSmall;

  TextStyle get bodyLarge => AppTextStyle.bodyLarge;
  TextStyle get bodyMedium => AppTextStyle.bodyMedium;
  TextStyle get bodySmall => AppTextStyle.bodySmall;

  // Theme-based colors with defaults
  Color get primaryColor => AppColors.primaryColor;
  Color get backgroundColor => AppColors.bg;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => AppColors.primaryColor;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get secondary => AppColors.secondaryColor;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get cardColor => Theme.of(this).cardColor;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;

  // App-specific colors
  Color get containerColor => AppColors.containerColor;
  Color get secondaryTextColor => AppColors.secondaryTextColor;
  Color get whiteColor => Colors.white;
  Color get blackColor => Colors.black;

  // Gaps for spacing
  Widget gap(double width, double height) =>
      SizedBox(width: width, height: height);

  Widget get g4 => gap(4, 4);
  Widget get g8 => gap(8, 8);
  Widget get g12 => gap(12, 12);
  Widget get g16 => gap(16, 16);
  Widget get g20 => gap(20, 20);
  Widget get g28 => gap(28, 28);
  Widget get g36 => gap(36, 36);
  Widget get g44 => gap(44, 44);
  Widget get g56 => gap(56, 56);

  // Simple spacing values
  double get sp4 => 4;
  double get sp8 => 8;
  double get sp12 => 12;
  double get sp16 => 16;
  double get sp20 => 20;
  double get sp28 => 28;
}
