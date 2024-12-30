import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// class TextFieldInputWidget extends StatelessWidget {
//   TextFieldInputWidget({super.key});
//   ChatController chatController = Get.find();
//   ThemeController themeController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(4),
//       // color: Colors.white,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 16,
//       ),

//       child: Obx(
//         () => Row(
//           textDirection: TextDirection.rtl,
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: chatController.textController.value,
//                 textAlign: TextAlign.right,
//                 textDirection: TextDirection.rtl,
//                 style: context.bodyLarge.copyWith(
//                   color: themeController
//                       .themes[themeController.currentThemeIndex.value]
//                       .inputText,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'رسالة',
//                   hintStyle: context.bodySmall.copyWith(
//                     color: themeController
//                         .themes[themeController.currentThemeIndex.value]
//                         .inputText
//                         .withOpacity(0.5),
//                   ),
//                   filled: true,
//                   fillColor: themeController
//                       .themes[themeController.currentThemeIndex.value]
//                       .inputField,
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Obx(
//               () => Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: chatController.textController.value.text.isEmpty
//                     ? InkWell(
//                         onTap: () {
//                           if (!chatController.status.value.isLoading) {
//                             chatController.handleSubmitted();
//                           }
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: themeController
//                                 .themes[themeController.currentThemeIndex.value]
//                                 .sendBtn,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             chatController.status.value.isLoading
//                                 ? Icons.pause
//                                 : FontAwesomeIcons.solidFilePdf,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       )
//                     : InkWell(
//                         onTap: () {
//                           if (!chatController.status.value.isLoading) {
//                             chatController.handleSubmitted();
//                           }
//                         },
//                         child: Container(
//                           padding: EdgeInsets.only(
//                             left:
//                                 chatController.status.value.isLoading ? 12 : 10,
//                             top: 12,
//                             right:
//                                 chatController.status.value.isLoading ? 12 : 14,
//                             bottom: 12,
//                           ),
//                           decoration: BoxDecoration(
//                             color: themeController
//                                 .themes[themeController.currentThemeIndex.value]
//                                 .sendBtn,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             chatController.status.value.isLoading
//                                 ? Icons.pause
//                                 : Icons.send_rounded,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TextFieldInputWidget extends StatelessWidget {
  TextFieldInputWidget({super.key});

  final ChatController chatController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () {
          final currentTheme =
              themeController.themes[themeController.currentThemeIndex.value];
          final isLoading = chatController.status.value.isLoading;
          final isTextFieldEmpty =
              chatController.textController.value.text.isEmpty;

          return Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: TextField(
                  controller: chatController.textController.value,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: context.bodyLarge.copyWith(
                    color: currentTheme.inputText,
                  ),
                  decoration: InputDecoration(
                    hintText: 'رسالة',
                    hintStyle: context.bodySmall.copyWith(
                      color: currentTheme.inputText.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: currentTheme.inputField,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // Force the UI to update when the text changes
                    chatController.textController.value.text = value;
                    chatController.textController.refresh();
                  },
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  if (isTextFieldEmpty) {
                    chatController.uploadFile();
                  } else {
                    isLoading ? null : chatController.handleSubmitted();
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  // padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: currentTheme.sendBtn,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Icon(
                        isLoading
                            ? FontAwesomeIcons.pause
                            // : isTextFieldEmpty
                            // ? FontAwesomeIcons.filePdf
                            : Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
