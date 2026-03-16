import 'package:drift/drift.dart';

class Tokens extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get token => text()();
  TextColumn get userName => text().nullable()();
  TextColumn get roleName => text().nullable()();
  TextColumn get outletName => text().nullable()();
}
