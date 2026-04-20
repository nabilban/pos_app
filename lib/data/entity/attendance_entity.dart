import 'package:drift/drift.dart';

@DataClassName('Attendance')
class Attendances extends Table {
  @JsonKey('ID')
  IntColumn get id => integer().nullable()();
  @JsonKey('user_id')
  IntColumn get userId => integer()();
  @JsonKey('photo_in')
  TextColumn get photoIn => text().nullable()();
  @JsonKey('photo_out')
  TextColumn get photoOut => text().nullable()();
  @JsonKey('check_in')
  TextColumn get checkIn => text().nullable()();
  @JsonKey('check_out')
  TextColumn get checkOut => text().nullable()();
  @JsonKey('sync_status')
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}
