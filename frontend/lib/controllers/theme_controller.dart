import 'package:flutter/material.dart';
import 'package:frontend/constants/colors.dart';
import 'package:get/get.dart';

class ThemeModel {
  final int id;
  final Color senderMessageText;
  final Color senderMessageBg;
  final Color background;
  final Color receiverMessageText;
  final Color receiverMessageBg;
  final Color sources;
  final Color sourcesText;
  final Color inputField;
  final Color sendBtn;
  final Color appBar;
  final Color appBarText;

  final Color inputText;
  final Color sendBtnText;

  ThemeModel({
    required this.sourcesText,
    required this.appBarText,
    required this.inputText,
    required this.sendBtnText,
    required this.id,
    required this.senderMessageText,
    required this.senderMessageBg,
    required this.background,
    required this.receiverMessageText,
    required this.receiverMessageBg,
    required this.sources,
    required this.inputField,
    required this.sendBtn,
    required this.appBar,
  });
}

class ThemeController extends GetxController {
  final currentThemeIndex = 0.obs;
  final themes = [
    ThemeModel(
      id: 0,
      senderMessageText: AppColors.whiteColor,
      senderMessageBg: AppColors.primaryColor,
      background: AppColors.whiteColor,
      receiverMessageText: AppColors.blackColor,
      receiverMessageBg: AppColors.containerColor,
      sources: AppColors.whiteColor,
      sourcesText: AppColors.secondaryTextColor,
      inputField: AppColors.secondaryTextColor.withOpacity(0.2),
      inputText: AppColors.blackColor,
      sendBtn: AppColors.primaryColor,
      sendBtnText: AppColors.whiteColor,
      appBar: AppColors.containerColor,
      appBarText: AppColors.secondaryColor,
    ),
    ThemeModel(
      id: 1,
      senderMessageText: AppColors.whiteColor,
      senderMessageBg: const Color.fromARGB(255, 49, 134, 52),
      background: AppColors.whiteColor,
      receiverMessageText: AppColors.blackColor,
      receiverMessageBg: AppColors.containerColor,
      sources: AppColors.whiteColor,
      sourcesText: AppColors.secondaryTextColor,
      inputField: AppColors.secondaryTextColor.withOpacity(0.2),
      inputText: AppColors.blackColor,
      sendBtn: const Color.fromARGB(255, 49, 134, 52),
      sendBtnText: AppColors.whiteColor,
      appBar: AppColors.containerColor,
      appBarText: AppColors.secondaryColor,
    ),
    ThemeModel(
      id: 2,
      senderMessageText: AppColors.whiteColor,
      senderMessageBg: const Color.fromARGB(255, 54, 4, 171),
      background: Colors.black87,
      receiverMessageText: AppColors.whiteColor,
      receiverMessageBg: Colors.white.withOpacity(0.1),
      sources: const Color(0xff666666),
      sourcesText: AppColors.whiteColor,
      inputField: const Color.fromARGB(255, 86, 86, 86),
      inputText: AppColors.whiteColor,
      sendBtn: const Color.fromARGB(255, 54, 4, 171),
      sendBtnText: AppColors.whiteColor,
      appBar: const Color(0xff555555),
      appBarText: AppColors.whiteColor,
    ),
  ];
  // ThemeModel get currentTheml => themes[currentThemeIndex.value];

  void setTheme(index) {
    currentThemeIndex.value = index;
  }
}
