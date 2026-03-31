// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SaleRequest _$SaleRequestFromJson(Map<String, dynamic> json) {
  return _SaleRequest.fromJson(json);
}

/// @nodoc
mixin _$SaleRequest {
  @JsonKey(name: 'payment_method_id')
  int get paymentMethodId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  List<SaleItemRequest> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_category_id')
  int? get priceCategoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'promo_id')
  int? get promoId => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'manual_discount')
  double get manualDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_fee')
  double get additionalFee => throw _privateConstructorUsedError;

  /// Serializes this SaleRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleRequestCopyWith<SaleRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleRequestCopyWith<$Res> {
  factory $SaleRequestCopyWith(
    SaleRequest value,
    $Res Function(SaleRequest) then,
  ) = _$SaleRequestCopyWithImpl<$Res, SaleRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'payment_method_id') int paymentMethodId,
    @JsonKey(name: 'customer_name') String customerName,
    List<SaleItemRequest> items,
    @JsonKey(name: 'price_category_id') int? priceCategoryId,
    @JsonKey(name: 'promo_id') int? promoId,
    String source,
    @JsonKey(name: 'manual_discount') double manualDiscount,
    @JsonKey(name: 'additional_fee') double additionalFee,
  });
}

/// @nodoc
class _$SaleRequestCopyWithImpl<$Res, $Val extends SaleRequest>
    implements $SaleRequestCopyWith<$Res> {
  _$SaleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethodId = null,
    Object? customerName = null,
    Object? items = null,
    Object? priceCategoryId = freezed,
    Object? promoId = freezed,
    Object? source = null,
    Object? manualDiscount = null,
    Object? additionalFee = null,
  }) {
    return _then(
      _value.copyWith(
            paymentMethodId: null == paymentMethodId
                ? _value.paymentMethodId
                : paymentMethodId // ignore: cast_nullable_to_non_nullable
                      as int,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<SaleItemRequest>,
            priceCategoryId: freezed == priceCategoryId
                ? _value.priceCategoryId
                : priceCategoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            promoId: freezed == promoId
                ? _value.promoId
                : promoId // ignore: cast_nullable_to_non_nullable
                      as int?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            manualDiscount: null == manualDiscount
                ? _value.manualDiscount
                : manualDiscount // ignore: cast_nullable_to_non_nullable
                      as double,
            additionalFee: null == additionalFee
                ? _value.additionalFee
                : additionalFee // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleRequestImplCopyWith<$Res>
    implements $SaleRequestCopyWith<$Res> {
  factory _$$SaleRequestImplCopyWith(
    _$SaleRequestImpl value,
    $Res Function(_$SaleRequestImpl) then,
  ) = __$$SaleRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'payment_method_id') int paymentMethodId,
    @JsonKey(name: 'customer_name') String customerName,
    List<SaleItemRequest> items,
    @JsonKey(name: 'price_category_id') int? priceCategoryId,
    @JsonKey(name: 'promo_id') int? promoId,
    String source,
    @JsonKey(name: 'manual_discount') double manualDiscount,
    @JsonKey(name: 'additional_fee') double additionalFee,
  });
}

/// @nodoc
class __$$SaleRequestImplCopyWithImpl<$Res>
    extends _$SaleRequestCopyWithImpl<$Res, _$SaleRequestImpl>
    implements _$$SaleRequestImplCopyWith<$Res> {
  __$$SaleRequestImplCopyWithImpl(
    _$SaleRequestImpl _value,
    $Res Function(_$SaleRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethodId = null,
    Object? customerName = null,
    Object? items = null,
    Object? priceCategoryId = freezed,
    Object? promoId = freezed,
    Object? source = null,
    Object? manualDiscount = null,
    Object? additionalFee = null,
  }) {
    return _then(
      _$SaleRequestImpl(
        paymentMethodId: null == paymentMethodId
            ? _value.paymentMethodId
            : paymentMethodId // ignore: cast_nullable_to_non_nullable
                  as int,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<SaleItemRequest>,
        priceCategoryId: freezed == priceCategoryId
            ? _value.priceCategoryId
            : priceCategoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        promoId: freezed == promoId
            ? _value.promoId
            : promoId // ignore: cast_nullable_to_non_nullable
                  as int?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        manualDiscount: null == manualDiscount
            ? _value.manualDiscount
            : manualDiscount // ignore: cast_nullable_to_non_nullable
                  as double,
        additionalFee: null == additionalFee
            ? _value.additionalFee
            : additionalFee // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleRequestImpl implements _SaleRequest {
  const _$SaleRequestImpl({
    @JsonKey(name: 'payment_method_id') required this.paymentMethodId,
    @JsonKey(name: 'customer_name') required this.customerName,
    required final List<SaleItemRequest> items,
    @JsonKey(name: 'price_category_id') this.priceCategoryId,
    @JsonKey(name: 'promo_id') this.promoId,
    this.source = 'pos',
    @JsonKey(name: 'manual_discount') this.manualDiscount = 0,
    @JsonKey(name: 'additional_fee') this.additionalFee = 0,
  }) : _items = items;

  factory _$SaleRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleRequestImplFromJson(json);

  @override
  @JsonKey(name: 'payment_method_id')
  final int paymentMethodId;
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  final List<SaleItemRequest> _items;
  @override
  List<SaleItemRequest> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'price_category_id')
  final int? priceCategoryId;
  @override
  @JsonKey(name: 'promo_id')
  final int? promoId;
  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey(name: 'manual_discount')
  final double manualDiscount;
  @override
  @JsonKey(name: 'additional_fee')
  final double additionalFee;

  @override
  String toString() {
    return 'SaleRequest(paymentMethodId: $paymentMethodId, customerName: $customerName, items: $items, priceCategoryId: $priceCategoryId, promoId: $promoId, source: $source, manualDiscount: $manualDiscount, additionalFee: $additionalFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleRequestImpl &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.priceCategoryId, priceCategoryId) ||
                other.priceCategoryId == priceCategoryId) &&
            (identical(other.promoId, promoId) || other.promoId == promoId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.manualDiscount, manualDiscount) ||
                other.manualDiscount == manualDiscount) &&
            (identical(other.additionalFee, additionalFee) ||
                other.additionalFee == additionalFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    paymentMethodId,
    customerName,
    const DeepCollectionEquality().hash(_items),
    priceCategoryId,
    promoId,
    source,
    manualDiscount,
    additionalFee,
  );

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleRequestImplCopyWith<_$SaleRequestImpl> get copyWith =>
      __$$SaleRequestImplCopyWithImpl<_$SaleRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleRequestImplToJson(this);
  }
}

abstract class _SaleRequest implements SaleRequest {
  const factory _SaleRequest({
    @JsonKey(name: 'payment_method_id') required final int paymentMethodId,
    @JsonKey(name: 'customer_name') required final String customerName,
    required final List<SaleItemRequest> items,
    @JsonKey(name: 'price_category_id') final int? priceCategoryId,
    @JsonKey(name: 'promo_id') final int? promoId,
    final String source,
    @JsonKey(name: 'manual_discount') final double manualDiscount,
    @JsonKey(name: 'additional_fee') final double additionalFee,
  }) = _$SaleRequestImpl;

  factory _SaleRequest.fromJson(Map<String, dynamic> json) =
      _$SaleRequestImpl.fromJson;

  @override
  @JsonKey(name: 'payment_method_id')
  int get paymentMethodId;
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  List<SaleItemRequest> get items;
  @override
  @JsonKey(name: 'price_category_id')
  int? get priceCategoryId;
  @override
  @JsonKey(name: 'promo_id')
  int? get promoId;
  @override
  String get source;
  @override
  @JsonKey(name: 'manual_discount')
  double get manualDiscount;
  @override
  @JsonKey(name: 'additional_fee')
  double get additionalFee;

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleRequestImplCopyWith<_$SaleRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItemRequest _$SaleItemRequestFromJson(Map<String, dynamic> json) {
  return _SaleItemRequest.fromJson(json);
}

/// @nodoc
mixin _$SaleItemRequest {
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  List<SaleVariantRequest> get variants => throw _privateConstructorUsedError;

  /// Serializes this SaleItemRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemRequestCopyWith<SaleItemRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemRequestCopyWith<$Res> {
  factory $SaleItemRequestCopyWith(
    SaleItemRequest value,
    $Res Function(SaleItemRequest) then,
  ) = _$SaleItemRequestCopyWithImpl<$Res, SaleItemRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'product_id') int productId,
    int quantity,
    double discount,
    List<SaleVariantRequest> variants,
  });
}

/// @nodoc
class _$SaleItemRequestCopyWithImpl<$Res, $Val extends SaleItemRequest>
    implements $SaleItemRequestCopyWith<$Res> {
  _$SaleItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? discount = null,
    Object? variants = null,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as double,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<SaleVariantRequest>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleItemRequestImplCopyWith<$Res>
    implements $SaleItemRequestCopyWith<$Res> {
  factory _$$SaleItemRequestImplCopyWith(
    _$SaleItemRequestImpl value,
    $Res Function(_$SaleItemRequestImpl) then,
  ) = __$$SaleItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'product_id') int productId,
    int quantity,
    double discount,
    List<SaleVariantRequest> variants,
  });
}

/// @nodoc
class __$$SaleItemRequestImplCopyWithImpl<$Res>
    extends _$SaleItemRequestCopyWithImpl<$Res, _$SaleItemRequestImpl>
    implements _$$SaleItemRequestImplCopyWith<$Res> {
  __$$SaleItemRequestImplCopyWithImpl(
    _$SaleItemRequestImpl _value,
    $Res Function(_$SaleItemRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? discount = null,
    Object? variants = null,
  }) {
    return _then(
      _$SaleItemRequestImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as double,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<SaleVariantRequest>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleItemRequestImpl implements _SaleItemRequest {
  const _$SaleItemRequestImpl({
    @JsonKey(name: 'product_id') required this.productId,
    required this.quantity,
    this.discount = 0,
    required final List<SaleVariantRequest> variants,
  }) : _variants = variants;

  factory _$SaleItemRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemRequestImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final int quantity;
  @override
  @JsonKey()
  final double discount;
  final List<SaleVariantRequest> _variants;
  @override
  List<SaleVariantRequest> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'SaleItemRequest(productId: $productId, quantity: $quantity, discount: $discount, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    quantity,
    discount,
    const DeepCollectionEquality().hash(_variants),
  );

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemRequestImplCopyWith<_$SaleItemRequestImpl> get copyWith =>
      __$$SaleItemRequestImplCopyWithImpl<_$SaleItemRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemRequestImplToJson(this);
  }
}

abstract class _SaleItemRequest implements SaleItemRequest {
  const factory _SaleItemRequest({
    @JsonKey(name: 'product_id') required final int productId,
    required final int quantity,
    final double discount,
    required final List<SaleVariantRequest> variants,
  }) = _$SaleItemRequestImpl;

  factory _SaleItemRequest.fromJson(Map<String, dynamic> json) =
      _$SaleItemRequestImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  int get quantity;
  @override
  double get discount;
  @override
  List<SaleVariantRequest> get variants;

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemRequestImplCopyWith<_$SaleItemRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleVariantRequest _$SaleVariantRequestFromJson(Map<String, dynamic> json) {
  return _SaleVariantRequest.fromJson(json);
}

/// @nodoc
mixin _$SaleVariantRequest {
  @JsonKey(name: 'variant_option_id')
  int get variantOptionId => throw _privateConstructorUsedError;

  /// Serializes this SaleVariantRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleVariantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleVariantRequestCopyWith<SaleVariantRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleVariantRequestCopyWith<$Res> {
  factory $SaleVariantRequestCopyWith(
    SaleVariantRequest value,
    $Res Function(SaleVariantRequest) then,
  ) = _$SaleVariantRequestCopyWithImpl<$Res, SaleVariantRequest>;
  @useResult
  $Res call({@JsonKey(name: 'variant_option_id') int variantOptionId});
}

/// @nodoc
class _$SaleVariantRequestCopyWithImpl<$Res, $Val extends SaleVariantRequest>
    implements $SaleVariantRequestCopyWith<$Res> {
  _$SaleVariantRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleVariantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? variantOptionId = null}) {
    return _then(
      _value.copyWith(
            variantOptionId: null == variantOptionId
                ? _value.variantOptionId
                : variantOptionId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleVariantRequestImplCopyWith<$Res>
    implements $SaleVariantRequestCopyWith<$Res> {
  factory _$$SaleVariantRequestImplCopyWith(
    _$SaleVariantRequestImpl value,
    $Res Function(_$SaleVariantRequestImpl) then,
  ) = __$$SaleVariantRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'variant_option_id') int variantOptionId});
}

/// @nodoc
class __$$SaleVariantRequestImplCopyWithImpl<$Res>
    extends _$SaleVariantRequestCopyWithImpl<$Res, _$SaleVariantRequestImpl>
    implements _$$SaleVariantRequestImplCopyWith<$Res> {
  __$$SaleVariantRequestImplCopyWithImpl(
    _$SaleVariantRequestImpl _value,
    $Res Function(_$SaleVariantRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleVariantRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? variantOptionId = null}) {
    return _then(
      _$SaleVariantRequestImpl(
        variantOptionId: null == variantOptionId
            ? _value.variantOptionId
            : variantOptionId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleVariantRequestImpl implements _SaleVariantRequest {
  const _$SaleVariantRequestImpl({
    @JsonKey(name: 'variant_option_id') required this.variantOptionId,
  });

  factory _$SaleVariantRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleVariantRequestImplFromJson(json);

  @override
  @JsonKey(name: 'variant_option_id')
  final int variantOptionId;

  @override
  String toString() {
    return 'SaleVariantRequest(variantOptionId: $variantOptionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleVariantRequestImpl &&
            (identical(other.variantOptionId, variantOptionId) ||
                other.variantOptionId == variantOptionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, variantOptionId);

  /// Create a copy of SaleVariantRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleVariantRequestImplCopyWith<_$SaleVariantRequestImpl> get copyWith =>
      __$$SaleVariantRequestImplCopyWithImpl<_$SaleVariantRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleVariantRequestImplToJson(this);
  }
}

abstract class _SaleVariantRequest implements SaleVariantRequest {
  const factory _SaleVariantRequest({
    @JsonKey(name: 'variant_option_id') required final int variantOptionId,
  }) = _$SaleVariantRequestImpl;

  factory _SaleVariantRequest.fromJson(Map<String, dynamic> json) =
      _$SaleVariantRequestImpl.fromJson;

  @override
  @JsonKey(name: 'variant_option_id')
  int get variantOptionId;

  /// Create a copy of SaleVariantRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleVariantRequestImplCopyWith<_$SaleVariantRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
