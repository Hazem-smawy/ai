import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/extension/context_extensions.dart';
import 'package:frontend/widget/choose_model_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    super.key,
  });

  ThemeController themeController = Get.find();
  ChatController chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        foregroundColor: themeController
            .themes[themeController.currentThemeIndex.value].appBarText,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          // Obx(
          //   () => Row(
          //     children: [
          //       if (chatController.pdfUploadStatus.value.isLoading)
          //         const SizedBox(
          //           width: 30,
          //           height: 30,
          //           child: CircularProgressIndicator(),
          //         ),
          //       if (chatController.pdfUploadStatus.value.isError)
          //         const SizedBox(
          //           width: 30,
          //           height: 30,
          //           child: FaIcon(
          //             FontAwesomeIcons.xmark,
          //             color: Colors.red,
          //           ),
          //         ),
          //       if (chatController.pdfUploadStatus.value.isSuccess)
          //         const SizedBox(
          //           width: 30,
          //           height: 30,
          //           child: FaIcon(
          //             FontAwesomeIcons.circleCheck,
          //             color: Colors.green,
          //           ),
          //         ),
          //       if (chatController.pdfUploadStatus.value.isEmpty)
          //         IconButton(
          //           onPressed: () {
          //             chatController.uploadFile();
          //           },
          //           icon: const FaIcon(
          //             FontAwesomeIcons.filePdf,
          //           ),
          //         )
          //     ],
          //   ),
          // ),
          IconButton(
            onPressed: () {
              chatController.getMessagesHistory();
            },
            icon: const FaIcon(
              FontAwesomeIcons.clock,
            ),
          ),
          context.g8,
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChooseModelWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
