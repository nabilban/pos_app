// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'CreatedAt')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'UpdatedAt')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'DeletedAt')
  String? get deletedAt => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_id')
  int? get brandId => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_id')
  int? get unitId => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  Brand? get brand => throw _privateConstructorUsedError;
  Unit? get unit => throw _privateConstructorUsedError;
  List<Variant> get variants => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'UpdatedAt') String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    String code,
    String name,
    String description,
    double price,
    int stock,
    String? image,
    String status,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'brand_id') int? brandId,
    @JsonKey(name: 'unit_id') int? unitId,
    Category? category,
    Brand? brand,
    Unit? unit,
    List<Variant> variants,
  });

  $CategoryCopyWith<$Res>? get category;
  $BrandCopyWith<$Res>? get brand;
  $UnitCopyWith<$Res>? get unit;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? code = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? stock = null,
    Object? image = freezed,
    Object? status = null,
    Object? categoryId = freezed,
    Object? brandId = freezed,
    Object? unitId = freezed,
    Object? category = freezed,
    Object? brand = freezed,
    Object? unit = freezed,
    Object? variants = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            stock: null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            brandId: freezed == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as int?,
            unitId: freezed == unitId
                ? _value.unitId
                : unitId // ignore: cast_nullable_to_non_nullable
                      as int?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as Category?,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as Brand?,
            unit: freezed == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as Unit?,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<Variant>,
          )
          as $Val,
    );
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandCopyWith<$Res>? get brand {
    if (_value.brand == null) {
      return null;
    }

    return $BrandCopyWith<$Res>(_value.brand!, (value) {
      return _then(_value.copyWith(brand: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitCopyWith<$Res>? get unit {
    if (_value.unit == null) {
      return null;
    }

    return $UnitCopyWith<$Res>(_value.unit!, (value) {
      return _then(_value.copyWith(unit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'UpdatedAt') String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    String code,
    String name,
    String description,
    double price,
    int stock,
    String? image,
    String status,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'brand_id') int? brandId,
    @JsonKey(name: 'unit_id') int? unitId,
    Category? category,
    Brand? brand,
    Unit? unit,
    List<Variant> variants,
  });

  @override
  $CategoryCopyWith<$Res>? get category;
  @override
  $BrandCopyWith<$Res>? get brand;
  @override
  $UnitCopyWith<$Res>? get unit;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? code = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? stock = null,
    Object? image = freezed,
    Object? status = null,
    Object? categoryId = freezed,
    Object? brandId = freezed,
    Object? unitId = freezed,
    Object? category = freezed,
    Object? brand = freezed,
    Object? unit = freezed,
    Object? variants = null,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        stock: null == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        brandId: freezed == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as int?,
        unitId: freezed == unitId
            ? _value.unitId
            : unitId // ignore: cast_nullable_to_non_nullable
                  as int?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as Category?,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as Brand?,
        unit: freezed == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as Unit?,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<Variant>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'CreatedAt') required this.createdAt,
    @JsonKey(name: 'UpdatedAt') required this.updatedAt,
    @JsonKey(name: 'DeletedAt') this.deletedAt,
    required this.code,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.image,
    this.status = "active",
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'brand_id') this.brandId,
    @JsonKey(name: 'unit_id') this.unitId,
    required this.category,
    required this.brand,
    required this.unit,
    final List<Variant> variants = const [],
  }) : _variants = variants;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey(name: 'CreatedAt')
  final String createdAt;
  @override
  @JsonKey(name: 'UpdatedAt')
  final String updatedAt;
  @override
  @JsonKey(name: 'DeletedAt')
  final String? deletedAt;
  @override
  final String code;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final int stock;
  @override
  final String? image;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'brand_id')
  final int? brandId;
  @override
  @JsonKey(name: 'unit_id')
  final int? unitId;
  @override
  final Category? category;
  @override
  final Brand? brand;
  @override
  final Unit? unit;
  final List<Variant> _variants;
  @override
  @JsonKey()
  List<Variant> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'Product(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, code: $code, name: $name, description: $description, price: $price, stock: $stock, image: $image, status: $status, categoryId: $categoryId, brandId: $brandId, unitId: $unitId, category: $category, brand: $brand, unit: $unit, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    description,
    price,
    stock,
    image,
    status,
    categoryId,
    brandId,
    unitId,
    category,
    brand,
    unit,
    const DeepCollectionEquality().hash(_variants),
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'CreatedAt') required final String createdAt,
    @JsonKey(name: 'UpdatedAt') required final String updatedAt,
    @JsonKey(name: 'DeletedAt') final String? deletedAt,
    required final String code,
    required final String name,
    required final String description,
    required final double price,
    required final int stock,
    final String? image,
    final String status,
    @JsonKey(name: 'category_id') final int? categoryId,
    @JsonKey(name: 'brand_id') final int? brandId,
    @JsonKey(name: 'unit_id') final int? unitId,
    required final Category? category,
    required final Brand? brand,
    required final Unit? unit,
    final List<Variant> variants,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  @JsonKey(name: 'CreatedAt')
  String get createdAt;
  @override
  @JsonKey(name: 'UpdatedAt')
  String get updatedAt;
  @override
  @JsonKey(name: 'DeletedAt')
  String? get deletedAt;
  @override
  String get code;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  int get stock;
  @override
  String? get image;
  @override
  String get status;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'brand_id')
  int? get brandId;
  @override
  @JsonKey(name: 'unit_id')
  int? get unitId;
  @override
  Category? get category;
  @override
  Brand? get brand;
  @override
  Unit? get unit;
  @override
  List<Variant> get variants;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
