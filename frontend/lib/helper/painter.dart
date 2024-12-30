// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/controllers/theme_controller.dart';
import 'package:frontend/models/message.dart';
import 'package:get/get.dart';

class ChatBubblePainter extends CustomPainter {
  final bool isMe;
  final Message message;

  final Color senderColor;
  final Color reciverColor;

  ChatBubblePainter({
    required this.isMe,
    required this.message,
    required this.senderColor,
    required this.reciverColor,
  });
  ThemeController themeController = Get.find();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isMe
          ? senderColor
          : message.status == MessageStatus.loading
              ? Colors.transparent
              : reciverColor
      ..style = PaintingStyle.fill;

    const bubbleRadius = 25.0;
    final path = Path();

    if (isMe) {
      // Right-side bubble with a tail
      path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: const Radius.circular(bubbleRadius),
        topRight: const Radius.circular(bubbleRadius),
        bottomLeft: const Radius.circular(bubbleRadius),
        bottomRight: const Radius.circular(bubbleRadius),
      ));
      // path.moveTo(size.width - 10, size.height); // Starting point of tail
      // path.lineTo(size.width + 10, size.height - 10); // Tail point
      // path.lineTo(size.width - 10, size.height - 20); // Closing the triangle
    } else {
      // Left-side bubble with a tail
      path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(10, 0, size.width, size.height),
        topLeft: const Radius.circular(bubbleRadius),
        topRight: const Radius.circular(bubbleRadius),
        bottomLeft: const Radius.circular(0),
        bottomRight: const Radius.circular(bubbleRadius),
      ));
      path.moveTo(10, size.height - 20); // Starting point of tail
      path.lineTo(-10, size.height - 10); // Tail point
      path.lineTo(10, size.height); // Closing the triangle
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


//new
