import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get username => text()();
  TextColumn get email => text()();
  IntColumn get roleId => integer()();
  IntColumn get outletId => integer().nullable()();
  BoolColumn get canAccessCenter => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
