import 'package:drift/drift.dart';

class MessageTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get msg => text()();
  BoolColumn get isMe => boolean()();
  IntColumn get status => integer()(); // Store MessageStatus as an integer
  DateTimeColumn get date => dateTime()();
}
