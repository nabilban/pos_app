import 'package:drift/drift.dart';

class Outlets extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get phone => text()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}
