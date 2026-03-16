// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'outlet.freezed.dart';
part 'outlet.g.dart';

@freezed
class Outlet with _$Outlet {
  const factory Outlet({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'UpdatedAt') required String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    required String name,
    required String address,
    required String phone,
    required String status,
  }) = _Outlet;

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
}
