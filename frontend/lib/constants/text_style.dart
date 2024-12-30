import 'package:flutter/material.dart';
import 'package:frontend/constants/colors.dart';

class AppTextStyle {
  static const String fontFamily = 'Cairo';

  static TextStyle get displayLarge => TextStyle(
        fontSize: 24,
        color: AppColors.blackColor,
        // fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      );
  static TextStyle get displayMedium => TextStyle(
        fontSize: 18,
        color: AppColors.blackColor,
        fontFamily: fontFamily,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get displaySmall => TextStyle(
        fontSize: 17,
        fontFamily: fontFamily,
        color: AppColors.blackColor,
      );
  static TextStyle get titleLarge => TextStyle(
        fontSize: 17,
        color: AppColors.blackColor,
        fontFamily: fontFamily,
        // fontWeight: FontWeight.bold,
      );
  static TextStyle get titleMedium => TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        color: AppColors.blackColor,
      );
  static TextStyle get titleSmall => TextStyle(
        fontSize: 15,
        fontFamily: fontFamily,
        color: AppColors.secondaryTextColor,
      );
  static TextStyle get bodyLarge => TextStyle(
        fontSize: 13,
        fontFamily: fontFamily,
        color: AppColors.secondaryTextColor,
        // fontWeight: FontWeight.bold,
      );
  static TextStyle get bodyMedium => TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        color: AppColors.secondaryTextColor,
      );
  static TextStyle get bodySmall => TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        color: AppColors.secondaryTextColor,
        fontWeight: FontWeight.normal,
      );
}
