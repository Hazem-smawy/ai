import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class ChooseModelWidget extends StatelessWidget {
  ChatController chatController = Get.find();
  final ThemeController themeController = Get.find();

  ChooseModelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (chatController.orginal.value == 0) {
          chatController.orginal.value = 1;
        } else {
          chatController.orginal.value = 0;
        }
      },
      child: Obx(
        () => Container(
          // width: MediaQuery.of(context).size.width / 3,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: themeController
                .themes[themeController.currentThemeIndex.value].appBar,
          ),
          child: Obx(
            () => chatController.orginal.value == 0
                ? ModelOptionWidget(
                    title: 'عام',
                    icon: FontAwesomeIcons.earthAfrica,
                  )
                : ModelOptionWidget(
                    title: 'خاص ب الملفات',
                    icon: FontAwesomeIcons.solidFilePdf,
                  ),
          ),
        ),
      ),
    );
  }
}

class ModelOptionWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  ModelOptionWidget({
    super.key,
    required this.title,
    required this.icon,
  });
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        context.g4,
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              color: themeController
                  .themes[themeController.currentThemeIndex.value].appBarText),
        ),
        const SizedBox(
          width: 12,
        ),
        Icon(
          icon,
          size: 20,
          color: themeController
              .themes[themeController.currentThemeIndex.value].appBarText,
        ),
        context.g4,
      ],
    );
  }
}
