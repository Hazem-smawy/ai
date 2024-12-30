// import 'package:flutter/material.dart';

// class AppColors {
//   static const Color blackColor = Color(0xff1b1b1b);
//   static const Color whiteColor = Color(0xffffffff);
//   static const Color sheetBgColor = Color(0xffEFEFEF);
//   static const Color primaryColor = Color(0xff0D988C);
//   static const Color secondaryColor = Color(0xff2B4141);

//   // static const Color bg = Color(0xffEBEEF3);
//   static const Color bg = Color(0xFFF1F1F1);
//   static const Color containerColor = Color(0xffeeeeee);
//   static const Color secondaryTextColor = Color(0xff777777);
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static Color get blackColor =>
      Get.isDarkMode ? const Color(0xff121212) : const Color(0xff1b1b1b);
  static Color get whiteColor => const Color(0xffffffff);
  static Color get sheetBgColor =>
      Get.isDarkMode ? const Color(0xff212121) : const Color(0xffEFEFEF);
  static Color get primaryColor => const Color.fromARGB(255, 40, 75, 218);
  static Color get secondaryColor =>
      Get.isDarkMode ? const Color(0xff424242) : const Color(0xff2B4141);
  static Color get bg =>
      Get.isDarkMode ? const Color(0xff121212) : const Color(0xFFF1F1F1);
  static Color get containerColor =>
      Get.isDarkMode ? const Color(0xff1E1E1E) : const Color(0xffeeeeee);
  static Color get secondaryTextColor =>
      Get.isDarkMode ? const Color(0xffB0B0B0) : const Color(0xff777777);
}
