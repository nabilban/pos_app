// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promo_check_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PromoCheckResponse _$PromoCheckResponseFromJson(Map<String, dynamic> json) {
  return _PromoCheckResponse.fromJson(json);
}

/// @nodoc
mixin _$PromoCheckResponse {
  @JsonKey(name: 'promo_id')
  int get promoId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'promo_type')
  String get promoType => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  double get discountAmount => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this PromoCheckResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromoCheckResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromoCheckResponseCopyWith<PromoCheckResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoCheckResponseCopyWith<$Res> {
  factory $PromoCheckResponseCopyWith(
    PromoCheckResponse value,
    $Res Function(PromoCheckResponse) then,
  ) = _$PromoCheckResponseCopyWithImpl<$Res, PromoCheckResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'promo_id') int promoId,
    String name,
    @JsonKey(name: 'promo_type') String promoType,
    @JsonKey(name: 'discount_amount') double discountAmount,
    String description,
  });
}

/// @nodoc
class _$PromoCheckResponseCopyWithImpl<$Res, $Val extends PromoCheckResponse>
    implements $PromoCheckResponseCopyWith<$Res> {
  _$PromoCheckResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromoCheckResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promoId = null,
    Object? name = null,
    Object? promoType = null,
    Object? discountAmount = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            promoId: null == promoId
                ? _value.promoId
                : promoId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            promoType: null == promoType
                ? _value.promoType
                : promoType // ignore: cast_nullable_to_non_nullable
                      as String,
            discountAmount: null == discountAmount
                ? _value.discountAmount
                : discountAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromoCheckResponseImplCopyWith<$Res>
    implements $PromoCheckResponseCopyWith<$Res> {
  factory _$$PromoCheckResponseImplCopyWith(
    _$PromoCheckResponseImpl value,
    $Res Function(_$PromoCheckResponseImpl) then,
  ) = __$$PromoCheckResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'promo_id') int promoId,
    String name,
    @JsonKey(name: 'promo_type') String promoType,
    @JsonKey(name: 'discount_amount') double discountAmount,
    String description,
  });
}

/// @nodoc
class __$$PromoCheckResponseImplCopyWithImpl<$Res>
    extends _$PromoCheckResponseCopyWithImpl<$Res, _$PromoCheckResponseImpl>
    implements _$$PromoCheckResponseImplCopyWith<$Res> {
  __$$PromoCheckResponseImplCopyWithImpl(
    _$PromoCheckResponseImpl _value,
    $Res Function(_$PromoCheckResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PromoCheckResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promoId = null,
    Object? name = null,
    Object? promoType = null,
    Object? discountAmount = null,
    Object? description = null,
  }) {
    return _then(
      _$PromoCheckResponseImpl(
        promoId: null == promoId
            ? _value.promoId
            : promoId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        promoType: null == promoType
            ? _value.promoType
            : promoType // ignore: cast_nullable_to_non_nullable
                  as String,
        discountAmount: null == discountAmount
            ? _value.discountAmount
            : discountAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromoCheckResponseImpl implements _PromoCheckResponse {
  const _$PromoCheckResponseImpl({
    @JsonKey(name: 'promo_id') required this.promoId,
    required this.name,
    @JsonKey(name: 'promo_type') required this.promoType,
    @JsonKey(name: 'discount_amount') required this.discountAmount,
    required this.description,
  });

  factory _$PromoCheckResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromoCheckResponseImplFromJson(json);

  @override
  @JsonKey(name: 'promo_id')
  final int promoId;
  @override
  final String name;
  @override
  @JsonKey(name: 'promo_type')
  final String promoType;
  @override
  @JsonKey(name: 'discount_amount')
  final double discountAmount;
  @override
  final String description;

  @override
  String toString() {
    return 'PromoCheckResponse(promoId: $promoId, name: $name, promoType: $promoType, discountAmount: $discountAmount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromoCheckResponseImpl &&
            (identical(other.promoId, promoId) || other.promoId == promoId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.promoType, promoType) ||
                other.promoType == promoType) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    promoId,
    name,
    promoType,
    discountAmount,
    description,
  );

  /// Create a copy of PromoCheckResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromoCheckResponseImplCopyWith<_$PromoCheckResponseImpl> get copyWith =>
      __$$PromoCheckResponseImplCopyWithImpl<_$PromoCheckResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PromoCheckResponseImplToJson(this);
  }
}

abstract class _PromoCheckResponse implements PromoCheckResponse {
  const factory _PromoCheckResponse({
    @JsonKey(name: 'promo_id') required final int promoId,
    required final String name,
    @JsonKey(name: 'promo_type') required final String promoType,
    @JsonKey(name: 'discount_amount') required final double discountAmount,
    required final String description,
  }) = _$PromoCheckResponseImpl;

  factory _PromoCheckResponse.fromJson(Map<String, dynamic> json) =
      _$PromoCheckResponseImpl.fromJson;

  @override
  @JsonKey(name: 'promo_id')
  int get promoId;
  @override
  String get name;
  @override
  @JsonKey(name: 'promo_type')
  String get promoType;
  @override
  @JsonKey(name: 'discount_amount')
  double get discountAmount;
  @override
  String get description;

  /// Create a copy of PromoCheckResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromoCheckResponseImplCopyWith<_$PromoCheckResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
