// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    super.key,
  });
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.containerColor,
      child: SafeArea(
        child: Column(
          children: [
            context.g36,
            Row(
              children: [
                context.g12,
                CircleAvatar(
                  radius: 25,
                  backgroundColor: context.secondary,
                ),
                context.g12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'name',
                      style: context.titleLarge,
                    ),
                    Text(
                      'name@gmail.com',
                      style: context.bodySmall,
                    ),
                  ],
                )
              ],
            ),
            context.g12,
            Divider(
              color: context.secondary.withOpacity(0.2),
              thickness: 0.5,
            ),
            context.g12,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: themeController.themes
                    .map((e) => ThemeOptionWidget(
                          theme: e,
                        ))
                    .toList(),
              ),
            ),
            Divider(
              color: context.secondary.withOpacity(0.2),
              thickness: 0.5,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'بدون خلفية',
            //         style: context.bodyLarge.copyWith(
            //           color: context.primaryColor,
            //         ),
            //       ),
            //       Text(
            //         'الخلفيات',
            //         style: context.displayLarge,
            //       )
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Row(
            //     children: [
            //       const BackgroundOptionWidget(),
            //       context.g12,
            //       const BackgroundOptionWidget(),
            //       context.g12,
            //       const BackgroundOptionWidget(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class BackgroundOptionWidget extends StatelessWidget {
  const BackgroundOptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Column(
              children: [
                context.g12,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeOptionWidget extends StatelessWidget {
  final ThemeModel theme;
  ThemeOptionWidget({
    super.key,
    required this.theme,
  });
  final ThemeController themeController = Get.find();
  ChatController chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 12,
        ),
        child: GestureDetector(
          onTap: () {
            themeController.setTheme(theme.id);
          },
          child: Obx(
            () => Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.background,
                  ),
                  child: Column(
                    children: [
                      context.g12,
                      Container(
                        margin: const EdgeInsets.only(
                          right: 5,
                          left: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: theme.senderMessageBg,
                        ),
                        padding: const EdgeInsets.all(7),
                      ),
                      context.g8,
                      Container(
                        margin: const EdgeInsets.only(
                          right: 30,
                          left: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: theme.receiverMessageBg,
                        ),
                        padding: const EdgeInsets.all(7),
                      )
                    ],
                  ),
                ),
                context.g12,
                Icon(
                  theme.id == themeController.currentThemeIndex.value
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 25,
                  color: context.secondaryTextColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
