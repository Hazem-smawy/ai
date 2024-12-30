import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:flutter/foundation.dart';
import 'package:frontend/service/message_talbel.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:drift_dev/api/migrations.dart';

part 'db.g.dart';

@DriftDatabase(
  tables: [MessageTable],
)
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase();

  static AppDatabase instance() => _instance;

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // Get all messages
  // Future<List<MessageTableData>> get allMessages => select(messageTable).get();
  Future<List<MessageTableData>> get allMessages => (select(messageTable)
        ..orderBy([
          (msg) => OrderingTerm(
                expression: msg.date,
                mode: OrderingMode.desc,
              )
        ]))
      .get();

  Future<List<MessageTableData>> getMessagesForToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = select(messageTable)
      ..where(
          (msg) => msg.date.isBetween(Constant(startOfDay), Constant(endOfDay)))
      ..orderBy([
        (msg) => OrderingTerm(
              expression: msg.date,
              mode: OrderingMode.desc,
            )
      ]);

    return await query.get();
  }

  // Insert a new message
  Future<int> insertMessage(MessageTableCompanion message) =>
      into(messageTable).insert(message);

  Future<void> deletemessage(int id) async {
    try {
      await (delete(messageTable)..where((m) => m.id.equals(id))).go();
    } catch (e) {
      rethrow; // Optionally rethrow the error
    }
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      ///This method is executed only the first time when database is created
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      ///This method is executed every time we increase the schemaVersion number
      ///In this method is where we are handling our migration
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          //await m.addColumn(artist, artist.isActive);
          ///The code line below is when you need to migrate newly added table
          //await m.create(newTable);
        }
      },

      ///This method is helpful as it help us during development phase to check if we did migration correctly
      beforeOpen: (details) async {
        if (kDebugMode) {
          await validateDatabaseSchema();
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
