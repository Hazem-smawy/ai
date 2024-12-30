import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:frontend/helper/check_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../helper/painter.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.id});
  final int id;
  final ChatController chatController = Get.find();
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    final message = chatController.messages.firstWhere((m) => m.id == id);
    final isMe = message.isMe;
    final regex = RegExp(r'\*\*Sources:\*\*\s*(.+)', dotAll: true);
    final match = regex.firstMatch(message.msg);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.black12,
                child: FaIcon(
                  FontAwesomeIcons.robot,
                  size: 17,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
          Obx(
            () => CustomPaint(
              painter: ChatBubblePainter(
                senderColor: themeController
                    .themes[themeController.currentThemeIndex.value]
                    .senderMessageBg,
                reciverColor: themeController
                    .themes[themeController.currentThemeIndex.value]
                    .receiverMessageBg,
                isMe: isMe,
                message: chatController.messages.firstWhere(
                  (msg) => msg.id == message.id,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 12,
                  right: 12,
                  bottom: 12,
                  left: isMe ? 12 : 20,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                child: message.status == MessageStatus.error
                    ? Text(
                        'error',
                        style: context.bodySmall.copyWith(
                            color: themeController
                                .themes[themeController.currentThemeIndex.value]
                                .receiverMessageText),
                      )
                    : message.status == MessageStatus.loading
                        ? SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: context.secondary.withOpacity(0.5),
                            ),
                          )
                        : Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  match != null
                                      ? message.msg
                                          .replaceFirst(match.group(0)!, '')
                                          .trim()
                                      : message.msg,
                                  textAlign: detectLanguage(message.msg) == 'ar'
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  textDirection:
                                      detectLanguage(message.msg) == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                  style: TextStyle(
                                    color: isMe
                                        ? themeController
                                            .themes[themeController
                                                .currentThemeIndex.value]
                                            .senderMessageText
                                        : themeController
                                            .themes[themeController
                                                .currentThemeIndex.value]
                                            .receiverMessageText,
                                    fontSize: 14.0,
                                  ),
                                ),
                                if (!isMe) context.g12,
                                if (!isMe && match != null)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: themeController
                                          .themes[themeController
                                              .currentThemeIndex.value]
                                          .sources,
                                    ),
                                    child: Text(
                                      match.group(1)!.trim(),
                                      style: context.bodyLarge.copyWith(
                                        color: themeController
                                            .themes[themeController
                                                .currentThemeIndex.value]
                                            .sourcesText,
                                      ),
                                    ),
                                  ),
                                if (!isMe)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      context.g12,
                                      Icon(
                                        size: 20,
                                        Icons.thumb_up_outlined,
                                        color: themeController
                                            .themes[themeController
                                                .currentThemeIndex.value]
                                            .receiverMessageText,
                                      ),
                                      context.g12,
                                      Icon(
                                        size: 20,
                                        Icons.content_copy_outlined,
                                        color: themeController
                                            .themes[themeController
                                                .currentThemeIndex.value]
                                            .receiverMessageText,
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
