import 'package:drift/drift.dart';
import 'package:frontend/controllers/chat_controller.dart';
import 'package:frontend/service/db.dart';

class Message {
  int id;
  String msg;
  bool isMe;
  MessageStatus status;
  DateTime date;
  Message({
    this.id = 0,
    required this.msg,
    required this.isMe,
    this.status = MessageStatus.empty,
    required this.date,
  });

  // Convert a drift row to a Message object
  factory Message.fromDrift(MessageTableData row) {
    return Message(
      id: row.id,
      msg: row.msg,
      isMe: row.isMe,
      status: MessageStatus.values[row.status],
      date: row.date,
    );
  }

  // Convert a Message object to a drift companion
  MessageTableCompanion toCompanion() {
    return MessageTableCompanion(
      msg: Value(msg),
      isMe: Value(isMe),
      status: Value(status.index),
      date: Value(date),
    );
  }
}
