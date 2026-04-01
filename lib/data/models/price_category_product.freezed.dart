// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_category_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PriceCategoryProduct _$PriceCategoryProductFromJson(Map<String, dynamic> json) {
  return _PriceCategoryProduct.fromJson(json);
}

/// @nodoc
mixin _$PriceCategoryProduct {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_category_id')
  int get priceCategoryId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;

  /// Serializes this PriceCategoryProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceCategoryProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceCategoryProductCopyWith<PriceCategoryProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceCategoryProductCopyWith<$Res> {
  factory $PriceCategoryProductCopyWith(
    PriceCategoryProduct value,
    $Res Function(PriceCategoryProduct) then,
  ) = _$PriceCategoryProductCopyWithImpl<$Res, PriceCategoryProduct>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'product_id') int productId,
    @JsonKey(name: 'price_category_id') int priceCategoryId,
    double price,
    Product? product,
  });

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$PriceCategoryProductCopyWithImpl<
  $Res,
  $Val extends PriceCategoryProduct
>
    implements $PriceCategoryProductCopyWith<$Res> {
  _$PriceCategoryProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceCategoryProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? priceCategoryId = null,
    Object? price = null,
    Object? product = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int,
            priceCategoryId: null == priceCategoryId
                ? _value.priceCategoryId
                : priceCategoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as Product?,
          )
          as $Val,
    );
  }

  /// Create a copy of PriceCategoryProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PriceCategoryProductImplCopyWith<$Res>
    implements $PriceCategoryProductCopyWith<$Res> {
  factory _$$PriceCategoryProductImplCopyWith(
    _$PriceCategoryProductImpl value,
    $Res Function(_$PriceCategoryProductImpl) then,
  ) = __$$PriceCategoryProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'product_id') int productId,
    @JsonKey(name: 'price_category_id') int priceCategoryId,
    double price,
    Product? product,
  });

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$PriceCategoryProductImplCopyWithImpl<$Res>
    extends _$PriceCategoryProductCopyWithImpl<$Res, _$PriceCategoryProductImpl>
    implements _$$PriceCategoryProductImplCopyWith<$Res> {
  __$$PriceCategoryProductImplCopyWithImpl(
    _$PriceCategoryProductImpl _value,
    $Res Function(_$PriceCategoryProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceCategoryProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? priceCategoryId = null,
    Object? price = null,
    Object? product = freezed,
  }) {
    return _then(
      _$PriceCategoryProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int,
        priceCategoryId: null == priceCategoryId
            ? _value.priceCategoryId
            : priceCategoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as Product?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceCategoryProductImpl implements _PriceCategoryProduct {
  const _$PriceCategoryProductImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'product_id') required this.productId,
    @JsonKey(name: 'price_category_id') required this.priceCategoryId,
    required this.price,
    this.product,
  });

  factory _$PriceCategoryProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceCategoryProductImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'price_category_id')
  final int priceCategoryId;
  @override
  final double price;
  @override
  final Product? product;

  @override
  String toString() {
    return 'PriceCategoryProduct(id: $id, productId: $productId, priceCategoryId: $priceCategoryId, price: $price, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceCategoryProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.priceCategoryId, priceCategoryId) ||
                other.priceCategoryId == priceCategoryId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, productId, priceCategoryId, price, product);

  /// Create a copy of PriceCategoryProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceCategoryProductImplCopyWith<_$PriceCategoryProductImpl>
  get copyWith =>
      __$$PriceCategoryProductImplCopyWithImpl<_$PriceCategoryProductImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceCategoryProductImplToJson(this);
  }
}

abstract class _PriceCategoryProduct implements PriceCategoryProduct {
  const factory _PriceCategoryProduct({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'product_id') required final int productId,
    @JsonKey(name: 'price_category_id') required final int priceCategoryId,
    required final double price,
    final Product? product,
  }) = _$PriceCategoryProductImpl;

  factory _PriceCategoryProduct.fromJson(Map<String, dynamic> json) =
      _$PriceCategoryProductImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'price_category_id')
  int get priceCategoryId;
  @override
  double get price;
  @override
  Product? get product;

  /// Create a copy of PriceCategoryProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceCategoryProductImplCopyWith<_$PriceCategoryProductImpl>
  get copyWith => throw _privateConstructorUsedError;
}
