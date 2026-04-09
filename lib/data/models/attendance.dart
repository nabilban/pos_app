// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    @JsonKey(name: 'ID') required int? id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'photo_in') String? photoIn,
    @JsonKey(name: 'photo_out') String? photoOut,
    @JsonKey(name: 'check_in') String? checkIn,
    @JsonKey(name: 'check_out') String? checkOut,
    @Default('pending') String syncStatus,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}
