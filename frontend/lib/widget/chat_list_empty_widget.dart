import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatListEmptyWidget extends StatelessWidget {
  ChatListEmptyWidget({
    super.key,
  });
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'كيف يمكنني مساعدتك اليوم ؟',
            style: TextStyle(
              fontSize: 22,
              color: themeController
                  .themes[themeController.currentThemeIndex.value]
                  .receiverMessageText,
            ),
          ),
          context.g12,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.secondaryTextColor.withOpacity(
                      0.2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'سؤال مباشر',
                      style: context.bodyLarge,
                    ),
                    context.g8,
                    FaIcon(
                      FontAwesomeIcons.internetExplorer,
                      size: 18,
                      color: context.secondaryTextColor,
                    )
                  ],
                ),
              ),
              context.g12,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.secondaryTextColor.withOpacity(
                      0.2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'سؤال عن ملف',
                      style: context.bodyLarge,
                    ),
                    context.g8,
                    FaIcon(
                      FontAwesomeIcons.filePdf,
                      size: 18,
                      color: context.secondaryTextColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
