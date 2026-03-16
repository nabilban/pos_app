// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'role.dart';
import 'outlet.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String message,
    required String token,
    required User user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'ID') required int id,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    @JsonKey(name: 'UpdatedAt') required String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    required String name,
    required String username,
    required String email,
    @JsonKey(name: 'role_id') required int roleId,
    @JsonKey(name: 'outlet_id') int? outletId,
    @JsonKey(name: 'can_access_center') required bool canAccessCenter,
    required Role role,
    Outlet? outlet,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
