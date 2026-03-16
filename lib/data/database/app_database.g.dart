// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TokensTable extends Tokens with TableInfo<$TokensTable, Token> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TokensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleNameMeta = const VerificationMeta(
    'roleName',
  );
  @override
  late final GeneratedColumn<String> roleName = GeneratedColumn<String>(
    'role_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outletNameMeta = const VerificationMeta(
    'outletName',
  );
  @override
  late final GeneratedColumn<String> outletName = GeneratedColumn<String>(
    'outlet_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    token,
    userName,
    roleName,
    outletName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tokens';
  @override
  VerificationContext validateIntegrity(
    Insertable<Token> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('role_name')) {
      context.handle(
        _roleNameMeta,
        roleName.isAcceptableOrUnknown(data['role_name']!, _roleNameMeta),
      );
    }
    if (data.containsKey('outlet_name')) {
      context.handle(
        _outletNameMeta,
        outletName.isAcceptableOrUnknown(data['outlet_name']!, _outletNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Token map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Token(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      ),
      roleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_name'],
      ),
      outletName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outlet_name'],
      ),
    );
  }

  @override
  $TokensTable createAlias(String alias) {
    return $TokensTable(attachedDatabase, alias);
  }
}

class Token extends DataClass implements Insertable<Token> {
  final int id;
  final String token;
  final String? userName;
  final String? roleName;
  final String? outletName;
  const Token({
    required this.id,
    required this.token,
    this.userName,
    this.roleName,
    this.outletName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['token'] = Variable<String>(token);
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    if (!nullToAbsent || roleName != null) {
      map['role_name'] = Variable<String>(roleName);
    }
    if (!nullToAbsent || outletName != null) {
      map['outlet_name'] = Variable<String>(outletName);
    }
    return map;
  }

  TokensCompanion toCompanion(bool nullToAbsent) {
    return TokensCompanion(
      id: Value(id),
      token: Value(token),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      roleName: roleName == null && nullToAbsent
          ? const Value.absent()
          : Value(roleName),
      outletName: outletName == null && nullToAbsent
          ? const Value.absent()
          : Value(outletName),
    );
  }

  factory Token.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Token(
      id: serializer.fromJson<int>(json['id']),
      token: serializer.fromJson<String>(json['token']),
      userName: serializer.fromJson<String?>(json['userName']),
      roleName: serializer.fromJson<String?>(json['roleName']),
      outletName: serializer.fromJson<String?>(json['outletName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'token': serializer.toJson<String>(token),
      'userName': serializer.toJson<String?>(userName),
      'roleName': serializer.toJson<String?>(roleName),
      'outletName': serializer.toJson<String?>(outletName),
    };
  }

  Token copyWith({
    int? id,
    String? token,
    Value<String?> userName = const Value.absent(),
    Value<String?> roleName = const Value.absent(),
    Value<String?> outletName = const Value.absent(),
  }) => Token(
    id: id ?? this.id,
    token: token ?? this.token,
    userName: userName.present ? userName.value : this.userName,
    roleName: roleName.present ? roleName.value : this.roleName,
    outletName: outletName.present ? outletName.value : this.outletName,
  );
  Token copyWithCompanion(TokensCompanion data) {
    return Token(
      id: data.id.present ? data.id.value : this.id,
      token: data.token.present ? data.token.value : this.token,
      userName: data.userName.present ? data.userName.value : this.userName,
      roleName: data.roleName.present ? data.roleName.value : this.roleName,
      outletName: data.outletName.present
          ? data.outletName.value
          : this.outletName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Token(')
          ..write('id: $id, ')
          ..write('token: $token, ')
          ..write('userName: $userName, ')
          ..write('roleName: $roleName, ')
          ..write('outletName: $outletName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, token, userName, roleName, outletName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Token &&
          other.id == this.id &&
          other.token == this.token &&
          other.userName == this.userName &&
          other.roleName == this.roleName &&
          other.outletName == this.outletName);
}

class TokensCompanion extends UpdateCompanion<Token> {
  final Value<int> id;
  final Value<String> token;
  final Value<String?> userName;
  final Value<String?> roleName;
  final Value<String?> outletName;
  const TokensCompanion({
    this.id = const Value.absent(),
    this.token = const Value.absent(),
    this.userName = const Value.absent(),
    this.roleName = const Value.absent(),
    this.outletName = const Value.absent(),
  });
  TokensCompanion.insert({
    this.id = const Value.absent(),
    required String token,
    this.userName = const Value.absent(),
    this.roleName = const Value.absent(),
    this.outletName = const Value.absent(),
  }) : token = Value(token);
  static Insertable<Token> custom({
    Expression<int>? id,
    Expression<String>? token,
    Expression<String>? userName,
    Expression<String>? roleName,
    Expression<String>? outletName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (token != null) 'token': token,
      if (userName != null) 'user_name': userName,
      if (roleName != null) 'role_name': roleName,
      if (outletName != null) 'outlet_name': outletName,
    });
  }

  TokensCompanion copyWith({
    Value<int>? id,
    Value<String>? token,
    Value<String?>? userName,
    Value<String?>? roleName,
    Value<String?>? outletName,
  }) {
    return TokensCompanion(
      id: id ?? this.id,
      token: token ?? this.token,
      userName: userName ?? this.userName,
      roleName: roleName ?? this.roleName,
      outletName: outletName ?? this.outletName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (roleName.present) {
      map['role_name'] = Variable<String>(roleName.value);
    }
    if (outletName.present) {
      map['outlet_name'] = Variable<String>(outletName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokensCompanion(')
          ..write('id: $id, ')
          ..write('token: $token, ')
          ..write('userName: $userName, ')
          ..write('roleName: $roleName, ')
          ..write('outletName: $outletName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TokensTable tokens = $TokensTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tokens];
}

typedef $$TokensTableCreateCompanionBuilder =
    TokensCompanion Function({
      Value<int> id,
      required String token,
      Value<String?> userName,
      Value<String?> roleName,
      Value<String?> outletName,
    });
typedef $$TokensTableUpdateCompanionBuilder =
    TokensCompanion Function({
      Value<int> id,
      Value<String> token,
      Value<String?> userName,
      Value<String?> roleName,
      Value<String?> outletName,
    });

class $$TokensTableFilterComposer
    extends Composer<_$AppDatabase, $TokensTable> {
  $$TokensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roleName => $composableBuilder(
    column: $table.roleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outletName => $composableBuilder(
    column: $table.outletName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TokensTableOrderingComposer
    extends Composer<_$AppDatabase, $TokensTable> {
  $$TokensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roleName => $composableBuilder(
    column: $table.roleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outletName => $composableBuilder(
    column: $table.outletName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TokensTableAnnotationComposer
    extends Composer<_$AppDatabase, $TokensTable> {
  $$TokensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get roleName =>
      $composableBuilder(column: $table.roleName, builder: (column) => column);

  GeneratedColumn<String> get outletName => $composableBuilder(
    column: $table.outletName,
    builder: (column) => column,
  );
}

class $$TokensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TokensTable,
          Token,
          $$TokensTableFilterComposer,
          $$TokensTableOrderingComposer,
          $$TokensTableAnnotationComposer,
          $$TokensTableCreateCompanionBuilder,
          $$TokensTableUpdateCompanionBuilder,
          (Token, BaseReferences<_$AppDatabase, $TokensTable, Token>),
          Token,
          PrefetchHooks Function()
        > {
  $$TokensTableTableManager(_$AppDatabase db, $TokensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TokensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TokensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TokensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> token = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<String?> roleName = const Value.absent(),
                Value<String?> outletName = const Value.absent(),
              }) => TokensCompanion(
                id: id,
                token: token,
                userName: userName,
                roleName: roleName,
                outletName: outletName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String token,
                Value<String?> userName = const Value.absent(),
                Value<String?> roleName = const Value.absent(),
                Value<String?> outletName = const Value.absent(),
              }) => TokensCompanion.insert(
                id: id,
                token: token,
                userName: userName,
                roleName: roleName,
                outletName: outletName,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TokensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TokensTable,
      Token,
      $$TokensTableFilterComposer,
      $$TokensTableOrderingComposer,
      $$TokensTableAnnotationComposer,
      $$TokensTableCreateCompanionBuilder,
      $$TokensTableUpdateCompanionBuilder,
      (Token, BaseReferences<_$AppDatabase, $TokensTable, Token>),
      Token,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TokensTableTableManager get tokens =>
      $$TokensTableTableManager(_db, _db.tokens);
}
