import 'package:drift/drift.dart';

class Attendances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  DateTimeColumn get checkInTime => dateTime()();
  DateTimeColumn get checkOutTime => dateTime().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // 'pending', 'synced'
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
