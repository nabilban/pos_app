import 'package:drift/drift.dart';

@DataClassName('Shift')
class Shifts extends Table {
  @JsonKey('ID')
  IntColumn get id => integer().nullable()();
  @JsonKey('user_id')
  IntColumn get userId => integer()();
  @JsonKey('cash_in')
  RealColumn get cashIn => real()();
  @JsonKey('cash_out')
  RealColumn get cashOut => real().nullable()();
  TextColumn get notes => text().nullable()();
  @JsonKey('start_time')
  DateTimeColumn get startTime => dateTime()();
  @JsonKey('end_time')
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  @JsonKey('sync_status')
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}
