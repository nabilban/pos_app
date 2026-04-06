import 'package:drift/drift.dart';

class Shifts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  RealColumn get cashIn => real()();
  RealColumn get cashOut => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('open'))(); // 'open', 'closed'
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // 'pending', 'synced'
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
