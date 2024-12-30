import 'package:flutter/material.dart';
import 'package:frontend/service/db.dart';
import 'package:get/get.dart';

import '../models/message.dart';
import '../service/chat_service.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

enum MessageStatus { empty, loading, success, error }

class ChatController extends GetxController {
  final db = AppDatabase.instance();
  RxString message = ''.obs;

  final orginal = 0.obs;
  final pdfUpload = false.obs;
  final textController = TextEditingController().obs;
  final status = RxStatus.empty().obs;
  final pdfUploadStatus = RxStatus.empty().obs;
  final messages = [].obs;
  int id = 0;

  @override
  onInit() {
    super.onInit();
    getMessages();
  }

  MessageStatus get currentStatus {
    if (status.value.isEmpty) return MessageStatus.empty;
    if (status.value.isLoading) return MessageStatus.loading;
    if (status.value.isSuccess) return MessageStatus.success;
    if (status.value.isError) return MessageStatus.error;
    return MessageStatus.empty; // Default to empty
  }

  MessageStatus get currentPdfUploadStatus {
    if (pdfUploadStatus.value.isEmpty) return MessageStatus.empty;
    if (pdfUploadStatus.value.isLoading) return MessageStatus.loading;
    if (pdfUploadStatus.value.isSuccess) return MessageStatus.success;
    if (pdfUploadStatus.value.isError) return MessageStatus.error;
    return MessageStatus.empty; // Default to empty
  }

  Future<void> handleSubmitted1() async {
    status.value = RxStatus.loading();
    int sendMessageId = 0;
    var reciveMessage = Message(
      msg: 'emptyMessage',
      isMe: false,
      status: MessageStatus.loading,
      date: DateTime.now(),
    );
    try {
      // Show loading status when the message is being processed
      status.value = RxStatus.loading();

      // Ensure the message text is not empty
      if (textController.value.text.trim().isEmpty) return;

      // Create a new message for the user
      final sendMessage = Message(
        msg: textController.value.text,
        isMe: true,
        date: DateTime.now(),
      );
      textController.value.clear();

      sendMessageId = await db.insertMessage(sendMessage.toCompanion());
      await getMessages();

      messages.insert(0, reciveMessage);

      final Map<String, dynamic> result = await sendChatQuery(
        textController.value.text,
        orginal.value == 0,
        pdfUpload.value,
      );

      // Update the received message with the bot's actual response
      reciveMessage = Message(
        msg: result['response'],
        isMe: false,
        status: MessageStatus.success,
        date: DateTime.now(),
      );

      // Insert the actual bot response into the database
      await db.insertMessage(reciveMessage.toCompanion());

      // Clear the text input field

      // Set the status to success or idle after processing
      await getMessages();
      status.value = RxStatus.success();
    } catch (e) {
      int index = messages.indexWhere(
        (element) => element.msg == 'emptyMessage',
      );

      messages[index] = Message(
        msg: '',
        isMe: false,
        status: MessageStatus.error,
        date: DateTime.now(),
      );

      await db.deletemessage(sendMessageId);

      status.value = RxStatus.error('An error occurred.');
    } finally {
      status.value = RxStatus.success();
    }
  }

  Future<void> handleSubmitted() async {
    int sendMessageId = 0;
    var receiveMessage = Message(
      msg: 'emptyMessage',
      isMe: false,
      status: MessageStatus.loading,
      date: DateTime.now(),
    );

    try {
      // Show loading status
      status.value = RxStatus.loading();

      // Validate message text
      final messageText = textController.value.text.trim();
      if (messageText.isEmpty) return;

      // Create and insert user message
      final userMessage = Message(
        msg: messageText,
        isMe: true,
        date: DateTime.now(),
      );
      sendMessageId = await db.insertMessage(userMessage.toCompanion());
      await getMessages();

      // Simulate bot typing
      messages.insert(0, receiveMessage);

      // Send chat query and get bot response
      final Map<String, dynamic> result = await sendChatQuery(
        messageText,
        orginal.value == 0,
        pdfUpload.value,
      );

      // Update bot response
      receiveMessage = Message(
        msg: result['response'],
        isMe: false,
        status: MessageStatus.success,
        date: DateTime.now(),
      );
      await db.insertMessage(receiveMessage.toCompanion());

      // Clear input field and update status
      textController.value.clear();
      await getMessages();
      status.value = RxStatus.success();
    } catch (e) {
      // Handle errors
      final errorIndex =
          messages.indexWhere((element) => element.msg == 'emptyMessage');
      if (errorIndex != -1) {
        messages[errorIndex] = Message(
          msg: 'Failed to send message. Please try again.',
          isMe: false,
          status: MessageStatus.error,
          date: DateTime.now(),
        );
      }

      // Clean up sent message in case of error
      if (sendMessageId != 0) {
        await db.deletemessage(sendMessageId);
      }

      // Log error and update status

      status.value = RxStatus.error('An error occurred.');
    }
  }

  Future<void> getMessages() async {
    final messagesData = await db.getMessagesForToday();
    messages.value = messagesData.map((row) => Message.fromDrift(row)).toList();
  }

  Future<void> getMessagesHistory() async {
    final messagesData = await db.allMessages;
    messages.value = messagesData.map((row) => Message.fromDrift(row)).toList();
  }

  Future<void> uploadFile() async {
    try {
      // Open file picker to select a file
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        pdfUploadStatus.value = RxStatus.loading();
        PlatformFile file = result.files.first;
        File fileToUpload = File(file.path!);

        print(fileToUpload);

        // Create a multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://127.0.0.1:5000/upload'),
        );

        // Add the file to the request
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            fileToUpload.path,
            filename: file.name,
          ),
        );

        // Send the request
        var response = await request.send();

        // Check the response
        if (response.statusCode == 200) {
          message.value = 'File uploaded successfully';
          pdfUpload.value = true;
          pdfUploadStatus.value = RxStatus.success();
        } else {
          message.value = 'Failed to upload file: ${response.reasonPhrase}';
        }
      } else {
        message.value = 'No file selected';
      }
    } catch (e) {
      pdfUploadStatus.value = RxStatus.error();

      message.value = 'Error uploading file: $e';
      print(message.value);
    }
  }
}
