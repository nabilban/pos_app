// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PriceCategory _$PriceCategoryFromJson(Map<String, dynamic> json) {
  return _PriceCategory.fromJson(json);
}

/// @nodoc
mixin _$PriceCategory {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PriceCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceCategoryCopyWith<PriceCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceCategoryCopyWith<$Res> {
  factory $PriceCategoryCopyWith(
    PriceCategory value,
    $Res Function(PriceCategory) then,
  ) = _$PriceCategoryCopyWithImpl<$Res, PriceCategory>;
  @useResult
  $Res call({@JsonKey(name: 'ID') int id, String name});
}

/// @nodoc
class _$PriceCategoryCopyWithImpl<$Res, $Val extends PriceCategory>
    implements $PriceCategoryCopyWith<$Res> {
  _$PriceCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceCategoryImplCopyWith<$Res>
    implements $PriceCategoryCopyWith<$Res> {
  factory _$$PriceCategoryImplCopyWith(
    _$PriceCategoryImpl value,
    $Res Function(_$PriceCategoryImpl) then,
  ) = __$$PriceCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'ID') int id, String name});
}

/// @nodoc
class __$$PriceCategoryImplCopyWithImpl<$Res>
    extends _$PriceCategoryCopyWithImpl<$Res, _$PriceCategoryImpl>
    implements _$$PriceCategoryImplCopyWith<$Res> {
  __$$PriceCategoryImplCopyWithImpl(
    _$PriceCategoryImpl _value,
    $Res Function(_$PriceCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$PriceCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceCategoryImpl implements _PriceCategory {
  const _$PriceCategoryImpl({
    @JsonKey(name: 'ID') required this.id,
    required this.name,
  });

  factory _$PriceCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'PriceCategory(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of PriceCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceCategoryImplCopyWith<_$PriceCategoryImpl> get copyWith =>
      __$$PriceCategoryImplCopyWithImpl<_$PriceCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceCategoryImplToJson(this);
  }
}

abstract class _PriceCategory implements PriceCategory {
  const factory _PriceCategory({
    @JsonKey(name: 'ID') required final int id,
    required final String name,
  }) = _$PriceCategoryImpl;

  factory _PriceCategory.fromJson(Map<String, dynamic> json) =
      _$PriceCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  String get name;

  /// Create a copy of PriceCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceCategoryImplCopyWith<_$PriceCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
