// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $MessageTableTable extends MessageTable
    with TableInfo<$MessageTableTable, MessageTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _msgMeta = const VerificationMeta('msg');
  @override
  late final GeneratedColumn<String> msg = GeneratedColumn<String>(
      'msg', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isMeMeta = const VerificationMeta('isMe');
  @override
  late final GeneratedColumn<bool> isMe = GeneratedColumn<bool>(
      'is_me', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_me" IN (0, 1))'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, msg, isMe, status, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_table';
  @override
  VerificationContext validateIntegrity(Insertable<MessageTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('msg')) {
      context.handle(
          _msgMeta, msg.isAcceptableOrUnknown(data['msg']!, _msgMeta));
    } else if (isInserting) {
      context.missing(_msgMeta);
    }
    if (data.containsKey('is_me')) {
      context.handle(
          _isMeMeta, isMe.isAcceptableOrUnknown(data['is_me']!, _isMeMeta));
    } else if (isInserting) {
      context.missing(_isMeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      msg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}msg'])!,
      isMe: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_me'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $MessageTableTable createAlias(String alias) {
    return $MessageTableTable(attachedDatabase, alias);
  }
}

class MessageTableData extends DataClass
    implements Insertable<MessageTableData> {
  final int id;
  final String msg;
  final bool isMe;
  final int status;
  final DateTime date;
  const MessageTableData(
      {required this.id,
      required this.msg,
      required this.isMe,
      required this.status,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['msg'] = Variable<String>(msg);
    map['is_me'] = Variable<bool>(isMe);
    map['status'] = Variable<int>(status);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  MessageTableCompanion toCompanion(bool nullToAbsent) {
    return MessageTableCompanion(
      id: Value(id),
      msg: Value(msg),
      isMe: Value(isMe),
      status: Value(status),
      date: Value(date),
    );
  }

  factory MessageTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageTableData(
      id: serializer.fromJson<int>(json['id']),
      msg: serializer.fromJson<String>(json['msg']),
      isMe: serializer.fromJson<bool>(json['isMe']),
      status: serializer.fromJson<int>(json['status']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'msg': serializer.toJson<String>(msg),
      'isMe': serializer.toJson<bool>(isMe),
      'status': serializer.toJson<int>(status),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  MessageTableData copyWith(
          {int? id, String? msg, bool? isMe, int? status, DateTime? date}) =>
      MessageTableData(
        id: id ?? this.id,
        msg: msg ?? this.msg,
        isMe: isMe ?? this.isMe,
        status: status ?? this.status,
        date: date ?? this.date,
      );
  MessageTableData copyWithCompanion(MessageTableCompanion data) {
    return MessageTableData(
      id: data.id.present ? data.id.value : this.id,
      msg: data.msg.present ? data.msg.value : this.msg,
      isMe: data.isMe.present ? data.isMe.value : this.isMe,
      status: data.status.present ? data.status.value : this.status,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageTableData(')
          ..write('id: $id, ')
          ..write('msg: $msg, ')
          ..write('isMe: $isMe, ')
          ..write('status: $status, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, msg, isMe, status, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageTableData &&
          other.id == this.id &&
          other.msg == this.msg &&
          other.isMe == this.isMe &&
          other.status == this.status &&
          other.date == this.date);
}

class MessageTableCompanion extends UpdateCompanion<MessageTableData> {
  final Value<int> id;
  final Value<String> msg;
  final Value<bool> isMe;
  final Value<int> status;
  final Value<DateTime> date;
  const MessageTableCompanion({
    this.id = const Value.absent(),
    this.msg = const Value.absent(),
    this.isMe = const Value.absent(),
    this.status = const Value.absent(),
    this.date = const Value.absent(),
  });
  MessageTableCompanion.insert({
    this.id = const Value.absent(),
    required String msg,
    required bool isMe,
    required int status,
    required DateTime date,
  })  : msg = Value(msg),
        isMe = Value(isMe),
        status = Value(status),
        date = Value(date);
  static Insertable<MessageTableData> custom({
    Expression<int>? id,
    Expression<String>? msg,
    Expression<bool>? isMe,
    Expression<int>? status,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (msg != null) 'msg': msg,
      if (isMe != null) 'is_me': isMe,
      if (status != null) 'status': status,
      if (date != null) 'date': date,
    });
  }

  MessageTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? msg,
      Value<bool>? isMe,
      Value<int>? status,
      Value<DateTime>? date}) {
    return MessageTableCompanion(
      id: id ?? this.id,
      msg: msg ?? this.msg,
      isMe: isMe ?? this.isMe,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (msg.present) {
      map['msg'] = Variable<String>(msg.value);
    }
    if (isMe.present) {
      map['is_me'] = Variable<bool>(isMe.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTableCompanion(')
          ..write('id: $id, ')
          ..write('msg: $msg, ')
          ..write('isMe: $isMe, ')
          ..write('status: $status, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MessageTableTable messageTable = $MessageTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [messageTable];
}

typedef $$MessageTableTableCreateCompanionBuilder = MessageTableCompanion
    Function({
  Value<int> id,
  required String msg,
  required bool isMe,
  required int status,
  required DateTime date,
});
typedef $$MessageTableTableUpdateCompanionBuilder = MessageTableCompanion
    Function({
  Value<int> id,
  Value<String> msg,
  Value<bool> isMe,
  Value<int> status,
  Value<DateTime> date,
});

class $$MessageTableTableFilterComposer
    extends Composer<_$AppDatabase, $MessageTableTable> {
  $$MessageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get msg => $composableBuilder(
      column: $table.msg, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMe => $composableBuilder(
      column: $table.isMe, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));
}

class $$MessageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageTableTable> {
  $$MessageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get msg => $composableBuilder(
      column: $table.msg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMe => $composableBuilder(
      column: $table.isMe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));
}

class $$MessageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageTableTable> {
  $$MessageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get msg =>
      $composableBuilder(column: $table.msg, builder: (column) => column);

  GeneratedColumn<bool> get isMe =>
      $composableBuilder(column: $table.isMe, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$MessageTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessageTableTable,
    MessageTableData,
    $$MessageTableTableFilterComposer,
    $$MessageTableTableOrderingComposer,
    $$MessageTableTableAnnotationComposer,
    $$MessageTableTableCreateCompanionBuilder,
    $$MessageTableTableUpdateCompanionBuilder,
    (
      MessageTableData,
      BaseReferences<_$AppDatabase, $MessageTableTable, MessageTableData>
    ),
    MessageTableData,
    PrefetchHooks Function()> {
  $$MessageTableTableTableManager(_$AppDatabase db, $MessageTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> msg = const Value.absent(),
            Value<bool> isMe = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              MessageTableCompanion(
            id: id,
            msg: msg,
            isMe: isMe,
            status: status,
            date: date,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String msg,
            required bool isMe,
            required int status,
            required DateTime date,
          }) =>
              MessageTableCompanion.insert(
            id: id,
            msg: msg,
            isMe: isMe,
            status: status,
            date: date,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MessageTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MessageTableTable,
    MessageTableData,
    $$MessageTableTableFilterComposer,
    $$MessageTableTableOrderingComposer,
    $$MessageTableTableAnnotationComposer,
    $$MessageTableTableCreateCompanionBuilder,
    $$MessageTableTableUpdateCompanionBuilder,
    (
      MessageTableData,
      BaseReferences<_$AppDatabase, $MessageTableTable, MessageTableData>
    ),
    MessageTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MessageTableTableTableManager get messageTable =>
      $$MessageTableTableTableManager(_db, _db.messageTable);
}
