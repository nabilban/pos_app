// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Variant _$VariantFromJson(Map<String, dynamic> json) {
  return _Variant.fromJson(json);
}

/// @nodoc
mixin _$Variant {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'CreatedAt')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'UpdatedAt')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'DeletedAt')
  String? get deletedAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_select')
  int get minSelect => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_select')
  int get maxSelect => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<VariantOption> get options => throw _privateConstructorUsedError;

  /// Serializes this Variant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Variant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantCopyWith<Variant> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantCopyWith<$Res> {
  factory $VariantCopyWith(Variant value, $Res Function(Variant) then) =
      _$VariantCopyWithImpl<$Res, Variant>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'UpdatedAt') String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    String name,
    String? description,
    @JsonKey(name: 'min_select') int minSelect,
    @JsonKey(name: 'max_select') int maxSelect,
    String status,
    List<VariantOption> options,
  });
}

/// @nodoc
class _$VariantCopyWithImpl<$Res, $Val extends Variant>
    implements $VariantCopyWith<$Res> {
  _$VariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Variant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? minSelect = null,
    Object? maxSelect = null,
    Object? status = null,
    Object? options = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            minSelect: null == minSelect
                ? _value.minSelect
                : minSelect // ignore: cast_nullable_to_non_nullable
                      as int,
            maxSelect: null == maxSelect
                ? _value.maxSelect
                : maxSelect // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<VariantOption>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VariantImplCopyWith<$Res> implements $VariantCopyWith<$Res> {
  factory _$$VariantImplCopyWith(
    _$VariantImpl value,
    $Res Function(_$VariantImpl) then,
  ) = __$$VariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'UpdatedAt') String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    String name,
    String? description,
    @JsonKey(name: 'min_select') int minSelect,
    @JsonKey(name: 'max_select') int maxSelect,
    String status,
    List<VariantOption> options,
  });
}

/// @nodoc
class __$$VariantImplCopyWithImpl<$Res>
    extends _$VariantCopyWithImpl<$Res, _$VariantImpl>
    implements _$$VariantImplCopyWith<$Res> {
  __$$VariantImplCopyWithImpl(
    _$VariantImpl _value,
    $Res Function(_$VariantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Variant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? minSelect = null,
    Object? maxSelect = null,
    Object? status = null,
    Object? options = null,
  }) {
    return _then(
      _$VariantImpl(
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
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        minSelect: null == minSelect
            ? _value.minSelect
            : minSelect // ignore: cast_nullable_to_non_nullable
                  as int,
        maxSelect: null == maxSelect
            ? _value.maxSelect
            : maxSelect // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<VariantOption>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantImpl implements _Variant {
  const _$VariantImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'CreatedAt') required this.createdAt,
    @JsonKey(name: 'UpdatedAt') required this.updatedAt,
    @JsonKey(name: 'DeletedAt') this.deletedAt,
    required this.name,
    this.description,
    @JsonKey(name: 'min_select') required this.minSelect,
    @JsonKey(name: 'max_select') required this.maxSelect,
    required this.status,
    required final List<VariantOption> options,
  }) : _options = options;

  factory _$VariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantImplFromJson(json);

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
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'min_select')
  final int minSelect;
  @override
  @JsonKey(name: 'max_select')
  final int maxSelect;
  @override
  final String status;
  final List<VariantOption> _options;
  @override
  List<VariantOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'Variant(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, name: $name, description: $description, minSelect: $minSelect, maxSelect: $maxSelect, status: $status, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.minSelect, minSelect) ||
                other.minSelect == minSelect) &&
            (identical(other.maxSelect, maxSelect) ||
                other.maxSelect == maxSelect) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAt,
    updatedAt,
    deletedAt,
    name,
    description,
    minSelect,
    maxSelect,
    status,
    const DeepCollectionEquality().hash(_options),
  );

  /// Create a copy of Variant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantImplCopyWith<_$VariantImpl> get copyWith =>
      __$$VariantImplCopyWithImpl<_$VariantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantImplToJson(this);
  }
}

abstract class _Variant implements Variant {
  const factory _Variant({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'CreatedAt') required final String createdAt,
    @JsonKey(name: 'UpdatedAt') required final String updatedAt,
    @JsonKey(name: 'DeletedAt') final String? deletedAt,
    required final String name,
    final String? description,
    @JsonKey(name: 'min_select') required final int minSelect,
    @JsonKey(name: 'max_select') required final int maxSelect,
    required final String status,
    required final List<VariantOption> options,
  }) = _$VariantImpl;

  factory _Variant.fromJson(Map<String, dynamic> json) = _$VariantImpl.fromJson;

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
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'min_select')
  int get minSelect;
  @override
  @JsonKey(name: 'max_select')
  int get maxSelect;
  @override
  String get status;
  @override
  List<VariantOption> get options;

  /// Create a copy of Variant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantImplCopyWith<_$VariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VariantOption _$VariantOptionFromJson(Map<String, dynamic> json) {
  return _VariantOption.fromJson(json);
}

/// @nodoc
mixin _$VariantOption {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'CreatedAt')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'UpdatedAt')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'DeletedAt')
  String? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_category_id')
  int get variantCategoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_price')
  double get additionalPrice => throw _privateConstructorUsedError;

  /// Serializes this VariantOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VariantOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantOptionCopyWith<VariantOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantOptionCopyWith<$Res> {
  factory $VariantOptionCopyWith(
    VariantOption value,
    $Res Function(VariantOption) then,
  ) = _$VariantOptionCopyWithImpl<$Res, VariantOption>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'UpdatedAt') String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    @JsonKey(name: 'variant_category_id') int variantCategoryId,
    String name,
    @JsonKey(name: 'additional_price') double additionalPrice,
  });
}

/// @nodoc
class _$VariantOptionCopyWithImpl<$Res, $Val extends VariantOption>
    implements $VariantOptionCopyWith<$Res> {
  _$VariantOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariantOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? variantCategoryId = null,
    Object? name = null,
    Object? additionalPrice = null,
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
            variantCategoryId: null == variantCategoryId
                ? _value.variantCategoryId
                : variantCategoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            additionalPrice: null == additionalPrice
                ? _value.additionalPrice
                : additionalPrice // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VariantOptionImplCopyWith<$Res>
    implements $VariantOptionCopyWith<$Res> {
  factory _$$VariantOptionImplCopyWith(
    _$VariantOptionImpl value,
    $Res Function(_$VariantOptionImpl) then,
  ) = __$$VariantOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'UpdatedAt') String updatedAt,
    @JsonKey(name: 'DeletedAt') String? deletedAt,
    @JsonKey(name: 'variant_category_id') int variantCategoryId,
    String name,
    @JsonKey(name: 'additional_price') double additionalPrice,
  });
}

/// @nodoc
class __$$VariantOptionImplCopyWithImpl<$Res>
    extends _$VariantOptionCopyWithImpl<$Res, _$VariantOptionImpl>
    implements _$$VariantOptionImplCopyWith<$Res> {
  __$$VariantOptionImplCopyWithImpl(
    _$VariantOptionImpl _value,
    $Res Function(_$VariantOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VariantOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? variantCategoryId = null,
    Object? name = null,
    Object? additionalPrice = null,
  }) {
    return _then(
      _$VariantOptionImpl(
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
        variantCategoryId: null == variantCategoryId
            ? _value.variantCategoryId
            : variantCategoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        additionalPrice: null == additionalPrice
            ? _value.additionalPrice
            : additionalPrice // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantOptionImpl implements _VariantOption {
  const _$VariantOptionImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'CreatedAt') required this.createdAt,
    @JsonKey(name: 'UpdatedAt') required this.updatedAt,
    @JsonKey(name: 'DeletedAt') this.deletedAt,
    @JsonKey(name: 'variant_category_id') required this.variantCategoryId,
    required this.name,
    @JsonKey(name: 'additional_price') required this.additionalPrice,
  });

  factory _$VariantOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantOptionImplFromJson(json);

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
  @JsonKey(name: 'variant_category_id')
  final int variantCategoryId;
  @override
  final String name;
  @override
  @JsonKey(name: 'additional_price')
  final double additionalPrice;

  @override
  String toString() {
    return 'VariantOption(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, variantCategoryId: $variantCategoryId, name: $name, additionalPrice: $additionalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.variantCategoryId, variantCategoryId) ||
                other.variantCategoryId == variantCategoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.additionalPrice, additionalPrice) ||
                other.additionalPrice == additionalPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAt,
    updatedAt,
    deletedAt,
    variantCategoryId,
    name,
    additionalPrice,
  );

  /// Create a copy of VariantOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantOptionImplCopyWith<_$VariantOptionImpl> get copyWith =>
      __$$VariantOptionImplCopyWithImpl<_$VariantOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantOptionImplToJson(this);
  }
}

abstract class _VariantOption implements VariantOption {
  const factory _VariantOption({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'CreatedAt') required final String createdAt,
    @JsonKey(name: 'UpdatedAt') required final String updatedAt,
    @JsonKey(name: 'DeletedAt') final String? deletedAt,
    @JsonKey(name: 'variant_category_id') required final int variantCategoryId,
    required final String name,
    @JsonKey(name: 'additional_price') required final double additionalPrice,
  }) = _$VariantOptionImpl;

  factory _VariantOption.fromJson(Map<String, dynamic> json) =
      _$VariantOptionImpl.fromJson;

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
  @JsonKey(name: 'variant_category_id')
  int get variantCategoryId;
  @override
  String get name;
  @override
  @JsonKey(name: 'additional_price')
  double get additionalPrice;

  /// Create a copy of VariantOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantOptionImplCopyWith<_$VariantOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
