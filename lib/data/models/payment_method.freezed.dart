// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return _PaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethod {
  int get ID => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_in_sale')
  bool get showInSale => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_in_purchase')
  bool get showInPurchase => throw _privateConstructorUsedError;
  @JsonKey(name: 'outlet_id')
  int? get outletId => throw _privateConstructorUsedError;
  Outlet? get outlet => throw _privateConstructorUsedError;

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodCopyWith<PaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
    PaymentMethod value,
    $Res Function(PaymentMethod) then,
  ) = _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
  @useResult
  $Res call({
    int ID,
    String name,
    @JsonKey(name: 'show_in_sale') bool showInSale,
    @JsonKey(name: 'show_in_purchase') bool showInPurchase,
    @JsonKey(name: 'outlet_id') int? outletId,
    Outlet? outlet,
  });

  $OutletCopyWith<$Res>? get outlet;
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = null,
    Object? name = null,
    Object? showInSale = null,
    Object? showInPurchase = null,
    Object? outletId = freezed,
    Object? outlet = freezed,
  }) {
    return _then(
      _value.copyWith(
            ID: null == ID
                ? _value.ID
                : ID // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            showInSale: null == showInSale
                ? _value.showInSale
                : showInSale // ignore: cast_nullable_to_non_nullable
                      as bool,
            showInPurchase: null == showInPurchase
                ? _value.showInPurchase
                : showInPurchase // ignore: cast_nullable_to_non_nullable
                      as bool,
            outletId: freezed == outletId
                ? _value.outletId
                : outletId // ignore: cast_nullable_to_non_nullable
                      as int?,
            outlet: freezed == outlet
                ? _value.outlet
                : outlet // ignore: cast_nullable_to_non_nullable
                      as Outlet?,
          )
          as $Val,
    );
  }

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutletCopyWith<$Res>? get outlet {
    if (_value.outlet == null) {
      return null;
    }

    return $OutletCopyWith<$Res>(_value.outlet!, (value) {
      return _then(_value.copyWith(outlet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentMethodImplCopyWith<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  factory _$$PaymentMethodImplCopyWith(
    _$PaymentMethodImpl value,
    $Res Function(_$PaymentMethodImpl) then,
  ) = __$$PaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int ID,
    String name,
    @JsonKey(name: 'show_in_sale') bool showInSale,
    @JsonKey(name: 'show_in_purchase') bool showInPurchase,
    @JsonKey(name: 'outlet_id') int? outletId,
    Outlet? outlet,
  });

  @override
  $OutletCopyWith<$Res>? get outlet;
}

/// @nodoc
class __$$PaymentMethodImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$PaymentMethodImpl>
    implements _$$PaymentMethodImplCopyWith<$Res> {
  __$$PaymentMethodImplCopyWithImpl(
    _$PaymentMethodImpl _value,
    $Res Function(_$PaymentMethodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ID = null,
    Object? name = null,
    Object? showInSale = null,
    Object? showInPurchase = null,
    Object? outletId = freezed,
    Object? outlet = freezed,
  }) {
    return _then(
      _$PaymentMethodImpl(
        ID: null == ID
            ? _value.ID
            : ID // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        showInSale: null == showInSale
            ? _value.showInSale
            : showInSale // ignore: cast_nullable_to_non_nullable
                  as bool,
        showInPurchase: null == showInPurchase
            ? _value.showInPurchase
            : showInPurchase // ignore: cast_nullable_to_non_nullable
                  as bool,
        outletId: freezed == outletId
            ? _value.outletId
            : outletId // ignore: cast_nullable_to_non_nullable
                  as int?,
        outlet: freezed == outlet
            ? _value.outlet
            : outlet // ignore: cast_nullable_to_non_nullable
                  as Outlet?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentMethodImpl implements _PaymentMethod {
  const _$PaymentMethodImpl({
    required this.ID,
    required this.name,
    @JsonKey(name: 'show_in_sale') required this.showInSale,
    @JsonKey(name: 'show_in_purchase') required this.showInPurchase,
    @JsonKey(name: 'outlet_id') this.outletId,
    this.outlet,
  });

  factory _$PaymentMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodImplFromJson(json);

  @override
  final int ID;
  @override
  final String name;
  @override
  @JsonKey(name: 'show_in_sale')
  final bool showInSale;
  @override
  @JsonKey(name: 'show_in_purchase')
  final bool showInPurchase;
  @override
  @JsonKey(name: 'outlet_id')
  final int? outletId;
  @override
  final Outlet? outlet;

  @override
  String toString() {
    return 'PaymentMethod(ID: $ID, name: $name, showInSale: $showInSale, showInPurchase: $showInPurchase, outletId: $outletId, outlet: $outlet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodImpl &&
            (identical(other.ID, ID) || other.ID == ID) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.showInSale, showInSale) ||
                other.showInSale == showInSale) &&
            (identical(other.showInPurchase, showInPurchase) ||
                other.showInPurchase == showInPurchase) &&
            (identical(other.outletId, outletId) ||
                other.outletId == outletId) &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ID,
    name,
    showInSale,
    showInPurchase,
    outletId,
    outlet,
  );

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      __$$PaymentMethodImplCopyWithImpl<_$PaymentMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodImplToJson(this);
  }
}

abstract class _PaymentMethod implements PaymentMethod {
  const factory _PaymentMethod({
    required final int ID,
    required final String name,
    @JsonKey(name: 'show_in_sale') required final bool showInSale,
    @JsonKey(name: 'show_in_purchase') required final bool showInPurchase,
    @JsonKey(name: 'outlet_id') final int? outletId,
    final Outlet? outlet,
  }) = _$PaymentMethodImpl;

  factory _PaymentMethod.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodImpl.fromJson;

  @override
  int get ID;
  @override
  String get name;
  @override
  @JsonKey(name: 'show_in_sale')
  bool get showInSale;
  @override
  @JsonKey(name: 'show_in_purchase')
  bool get showInPurchase;
  @override
  @JsonKey(name: 'outlet_id')
  int? get outletId;
  @override
  Outlet? get outlet;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
