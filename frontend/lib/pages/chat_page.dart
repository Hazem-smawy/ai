import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:frontend/widget/app_bar_widget.dart';
import 'package:frontend/widget/chat_bubble.dart';
import 'package:frontend/widget/chat_list_empty_widget.dart';
import 'package:frontend/widget/drawer_widget.dart';
import 'package:frontend/widget/text_field_input_widget.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final ThemeController themeController = Get.put(ThemeController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: themeController
            .themes[themeController.currentThemeIndex.value]
            .background, // Light yellow background
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarWidget(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (chatController.messages.isEmpty) ChatListEmptyWidget(),
              // Chat Messages
              if (chatController.messages.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: chatController.messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        id: chatController.messages[index].id,
                      );
                    },
                  ),
                ),
              // Input Field
              context.g4,
              TextFieldInputWidget(),
              context.g8,
            ],
          ),
        ),
      ),
    );
  }
}
