// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'UpdatedAt') required String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    required String name,
    Map<String, dynamic>? permissions,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
