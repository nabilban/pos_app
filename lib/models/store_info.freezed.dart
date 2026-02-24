// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoreInfo _$StoreInfoFromJson(Map<String, dynamic> json) {
  return _StoreInfo.fromJson(json);
}

/// @nodoc
mixin _$StoreInfo {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get cashierName => throw _privateConstructorUsedError;

  /// Serializes this StoreInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoreInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreInfoCopyWith<StoreInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreInfoCopyWith<$Res> {
  factory $StoreInfoCopyWith(StoreInfo value, $Res Function(StoreInfo) then) =
      _$StoreInfoCopyWithImpl<$Res, StoreInfo>;
  @useResult
  $Res call({String name, String address, String phone, String cashierName});
}

/// @nodoc
class _$StoreInfoCopyWithImpl<$Res, $Val extends StoreInfo>
    implements $StoreInfoCopyWith<$Res> {
  _$StoreInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? cashierName = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            cashierName: null == cashierName
                ? _value.cashierName
                : cashierName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoreInfoImplCopyWith<$Res>
    implements $StoreInfoCopyWith<$Res> {
  factory _$$StoreInfoImplCopyWith(
    _$StoreInfoImpl value,
    $Res Function(_$StoreInfoImpl) then,
  ) = __$$StoreInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String address, String phone, String cashierName});
}

/// @nodoc
class __$$StoreInfoImplCopyWithImpl<$Res>
    extends _$StoreInfoCopyWithImpl<$Res, _$StoreInfoImpl>
    implements _$$StoreInfoImplCopyWith<$Res> {
  __$$StoreInfoImplCopyWithImpl(
    _$StoreInfoImpl _value,
    $Res Function(_$StoreInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? cashierName = null,
  }) {
    return _then(
      _$StoreInfoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        cashierName: null == cashierName
            ? _value.cashierName
            : cashierName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreInfoImpl implements _StoreInfo {
  const _$StoreInfoImpl({
    required this.name,
    required this.address,
    required this.phone,
    required this.cashierName,
  });

  factory _$StoreInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String address;
  @override
  final String phone;
  @override
  final String cashierName;

  @override
  String toString() {
    return 'StoreInfo(name: $name, address: $address, phone: $phone, cashierName: $cashierName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.cashierName, cashierName) ||
                other.cashierName == cashierName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, address, phone, cashierName);

  /// Create a copy of StoreInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreInfoImplCopyWith<_$StoreInfoImpl> get copyWith =>
      __$$StoreInfoImplCopyWithImpl<_$StoreInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreInfoImplToJson(this);
  }
}

abstract class _StoreInfo implements StoreInfo {
  const factory _StoreInfo({
    required final String name,
    required final String address,
    required final String phone,
    required final String cashierName,
  }) = _$StoreInfoImpl;

  factory _StoreInfo.fromJson(Map<String, dynamic> json) =
      _$StoreInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get address;
  @override
  String get phone;
  @override
  String get cashierName;

  /// Create a copy of StoreInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreInfoImplCopyWith<_$StoreInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
