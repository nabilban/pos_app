// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Promo _$PromoFromJson(Map<String, dynamic> json) {
  return _Promo.fromJson(json);
}

/// @nodoc
mixin _$Promo {
  @JsonKey(name: 'ID')
  int get promoId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'promo_type')
  String get promoType => throw _privateConstructorUsedError;
  @JsonKey(name: 'applies_to')
  String get appliesTo => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_qty')
  int get minQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_total')
  double get minTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_pct')
  double get discountPct => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_discount')
  double get maxDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'cut_price')
  double get cutPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'voucher_type')
  String? get voucherType => throw _privateConstructorUsedError;
  @JsonKey(name: 'voucher_code')
  String? get voucherCode => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this Promo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Promo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromoCopyWith<Promo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoCopyWith<$Res> {
  factory $PromoCopyWith(Promo value, $Res Function(Promo) then) =
      _$PromoCopyWithImpl<$Res, Promo>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int promoId,
    String name,
    @JsonKey(name: 'promo_type') String promoType,
    @JsonKey(name: 'applies_to') String appliesTo,
    String condition,
    @JsonKey(name: 'min_qty') int minQty,
    @JsonKey(name: 'min_total') double minTotal,
    @JsonKey(name: 'discount_pct') double discountPct,
    @JsonKey(name: 'max_discount') double maxDiscount,
    @JsonKey(name: 'cut_price') double cutPrice,
    @JsonKey(name: 'voucher_type') String? voucherType,
    @JsonKey(name: 'voucher_code') String? voucherCode,
    String? status,
  });
}

/// @nodoc
class _$PromoCopyWithImpl<$Res, $Val extends Promo>
    implements $PromoCopyWith<$Res> {
  _$PromoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Promo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promoId = null,
    Object? name = null,
    Object? promoType = null,
    Object? appliesTo = null,
    Object? condition = null,
    Object? minQty = null,
    Object? minTotal = null,
    Object? discountPct = null,
    Object? maxDiscount = null,
    Object? cutPrice = null,
    Object? voucherType = freezed,
    Object? voucherCode = freezed,
    Object? status = freezed,
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
            appliesTo: null == appliesTo
                ? _value.appliesTo
                : appliesTo // ignore: cast_nullable_to_non_nullable
                      as String,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as String,
            minQty: null == minQty
                ? _value.minQty
                : minQty // ignore: cast_nullable_to_non_nullable
                      as int,
            minTotal: null == minTotal
                ? _value.minTotal
                : minTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            discountPct: null == discountPct
                ? _value.discountPct
                : discountPct // ignore: cast_nullable_to_non_nullable
                      as double,
            maxDiscount: null == maxDiscount
                ? _value.maxDiscount
                : maxDiscount // ignore: cast_nullable_to_non_nullable
                      as double,
            cutPrice: null == cutPrice
                ? _value.cutPrice
                : cutPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            voucherType: freezed == voucherType
                ? _value.voucherType
                : voucherType // ignore: cast_nullable_to_non_nullable
                      as String?,
            voucherCode: freezed == voucherCode
                ? _value.voucherCode
                : voucherCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PromoImplCopyWith<$Res> implements $PromoCopyWith<$Res> {
  factory _$$PromoImplCopyWith(
    _$PromoImpl value,
    $Res Function(_$PromoImpl) then,
  ) = __$$PromoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int promoId,
    String name,
    @JsonKey(name: 'promo_type') String promoType,
    @JsonKey(name: 'applies_to') String appliesTo,
    String condition,
    @JsonKey(name: 'min_qty') int minQty,
    @JsonKey(name: 'min_total') double minTotal,
    @JsonKey(name: 'discount_pct') double discountPct,
    @JsonKey(name: 'max_discount') double maxDiscount,
    @JsonKey(name: 'cut_price') double cutPrice,
    @JsonKey(name: 'voucher_type') String? voucherType,
    @JsonKey(name: 'voucher_code') String? voucherCode,
    String? status,
  });
}

/// @nodoc
class __$$PromoImplCopyWithImpl<$Res>
    extends _$PromoCopyWithImpl<$Res, _$PromoImpl>
    implements _$$PromoImplCopyWith<$Res> {
  __$$PromoImplCopyWithImpl(
    _$PromoImpl _value,
    $Res Function(_$PromoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Promo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promoId = null,
    Object? name = null,
    Object? promoType = null,
    Object? appliesTo = null,
    Object? condition = null,
    Object? minQty = null,
    Object? minTotal = null,
    Object? discountPct = null,
    Object? maxDiscount = null,
    Object? cutPrice = null,
    Object? voucherType = freezed,
    Object? voucherCode = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$PromoImpl(
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
        appliesTo: null == appliesTo
            ? _value.appliesTo
            : appliesTo // ignore: cast_nullable_to_non_nullable
                  as String,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as String,
        minQty: null == minQty
            ? _value.minQty
            : minQty // ignore: cast_nullable_to_non_nullable
                  as int,
        minTotal: null == minTotal
            ? _value.minTotal
            : minTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        discountPct: null == discountPct
            ? _value.discountPct
            : discountPct // ignore: cast_nullable_to_non_nullable
                  as double,
        maxDiscount: null == maxDiscount
            ? _value.maxDiscount
            : maxDiscount // ignore: cast_nullable_to_non_nullable
                  as double,
        cutPrice: null == cutPrice
            ? _value.cutPrice
            : cutPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        voucherType: freezed == voucherType
            ? _value.voucherType
            : voucherType // ignore: cast_nullable_to_non_nullable
                  as String?,
        voucherCode: freezed == voucherCode
            ? _value.voucherCode
            : voucherCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromoImpl implements _Promo {
  const _$PromoImpl({
    @JsonKey(name: 'ID') required this.promoId,
    required this.name,
    @JsonKey(name: 'promo_type') required this.promoType,
    @JsonKey(name: 'applies_to') required this.appliesTo,
    required this.condition,
    @JsonKey(name: 'min_qty') required this.minQty,
    @JsonKey(name: 'min_total') required this.minTotal,
    @JsonKey(name: 'discount_pct') required this.discountPct,
    @JsonKey(name: 'max_discount') required this.maxDiscount,
    @JsonKey(name: 'cut_price') required this.cutPrice,
    @JsonKey(name: 'voucher_type') this.voucherType,
    @JsonKey(name: 'voucher_code') this.voucherCode,
    this.status,
  });

  factory _$PromoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromoImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int promoId;
  @override
  final String name;
  @override
  @JsonKey(name: 'promo_type')
  final String promoType;
  @override
  @JsonKey(name: 'applies_to')
  final String appliesTo;
  @override
  final String condition;
  @override
  @JsonKey(name: 'min_qty')
  final int minQty;
  @override
  @JsonKey(name: 'min_total')
  final double minTotal;
  @override
  @JsonKey(name: 'discount_pct')
  final double discountPct;
  @override
  @JsonKey(name: 'max_discount')
  final double maxDiscount;
  @override
  @JsonKey(name: 'cut_price')
  final double cutPrice;
  @override
  @JsonKey(name: 'voucher_type')
  final String? voucherType;
  @override
  @JsonKey(name: 'voucher_code')
  final String? voucherCode;
  @override
  final String? status;

  @override
  String toString() {
    return 'Promo(promoId: $promoId, name: $name, promoType: $promoType, appliesTo: $appliesTo, condition: $condition, minQty: $minQty, minTotal: $minTotal, discountPct: $discountPct, maxDiscount: $maxDiscount, cutPrice: $cutPrice, voucherType: $voucherType, voucherCode: $voucherCode, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromoImpl &&
            (identical(other.promoId, promoId) || other.promoId == promoId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.promoType, promoType) ||
                other.promoType == promoType) &&
            (identical(other.appliesTo, appliesTo) ||
                other.appliesTo == appliesTo) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.minQty, minQty) || other.minQty == minQty) &&
            (identical(other.minTotal, minTotal) ||
                other.minTotal == minTotal) &&
            (identical(other.discountPct, discountPct) ||
                other.discountPct == discountPct) &&
            (identical(other.maxDiscount, maxDiscount) ||
                other.maxDiscount == maxDiscount) &&
            (identical(other.cutPrice, cutPrice) ||
                other.cutPrice == cutPrice) &&
            (identical(other.voucherType, voucherType) ||
                other.voucherType == voucherType) &&
            (identical(other.voucherCode, voucherCode) ||
                other.voucherCode == voucherCode) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    promoId,
    name,
    promoType,
    appliesTo,
    condition,
    minQty,
    minTotal,
    discountPct,
    maxDiscount,
    cutPrice,
    voucherType,
    voucherCode,
    status,
  );

  /// Create a copy of Promo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromoImplCopyWith<_$PromoImpl> get copyWith =>
      __$$PromoImplCopyWithImpl<_$PromoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromoImplToJson(this);
  }
}

abstract class _Promo implements Promo {
  const factory _Promo({
    @JsonKey(name: 'ID') required final int promoId,
    required final String name,
    @JsonKey(name: 'promo_type') required final String promoType,
    @JsonKey(name: 'applies_to') required final String appliesTo,
    required final String condition,
    @JsonKey(name: 'min_qty') required final int minQty,
    @JsonKey(name: 'min_total') required final double minTotal,
    @JsonKey(name: 'discount_pct') required final double discountPct,
    @JsonKey(name: 'max_discount') required final double maxDiscount,
    @JsonKey(name: 'cut_price') required final double cutPrice,
    @JsonKey(name: 'voucher_type') final String? voucherType,
    @JsonKey(name: 'voucher_code') final String? voucherCode,
    final String? status,
  }) = _$PromoImpl;

  factory _Promo.fromJson(Map<String, dynamic> json) = _$PromoImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get promoId;
  @override
  String get name;
  @override
  @JsonKey(name: 'promo_type')
  String get promoType;
  @override
  @JsonKey(name: 'applies_to')
  String get appliesTo;
  @override
  String get condition;
  @override
  @JsonKey(name: 'min_qty')
  int get minQty;
  @override
  @JsonKey(name: 'min_total')
  double get minTotal;
  @override
  @JsonKey(name: 'discount_pct')
  double get discountPct;
  @override
  @JsonKey(name: 'max_discount')
  double get maxDiscount;
  @override
  @JsonKey(name: 'cut_price')
  double get cutPrice;
  @override
  @JsonKey(name: 'voucher_type')
  String? get voucherType;
  @override
  @JsonKey(name: 'voucher_code')
  String? get voucherCode;
  @override
  String? get status;

  /// Create a copy of Promo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromoImplCopyWith<_$PromoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
