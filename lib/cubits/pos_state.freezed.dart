// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PosState {
  String get selectedCategory => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PosStateCopyWith<PosState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PosStateCopyWith<$Res> {
  factory $PosStateCopyWith(PosState value, $Res Function(PosState) then) =
      _$PosStateCopyWithImpl<$Res, PosState>;
  @useResult
  $Res call({
    String selectedCategory,
    List<Product> products,
    List<String> categories,
    bool isLoading,
  });
}

/// @nodoc
class _$PosStateCopyWithImpl<$Res, $Val extends PosState>
    implements $PosStateCopyWith<$Res> {
  _$PosStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCategory = null,
    Object? products = null,
    Object? categories = null,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            selectedCategory: null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<Product>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PosStateImplCopyWith<$Res>
    implements $PosStateCopyWith<$Res> {
  factory _$$PosStateImplCopyWith(
    _$PosStateImpl value,
    $Res Function(_$PosStateImpl) then,
  ) = __$$PosStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String selectedCategory,
    List<Product> products,
    List<String> categories,
    bool isLoading,
  });
}

/// @nodoc
class __$$PosStateImplCopyWithImpl<$Res>
    extends _$PosStateCopyWithImpl<$Res, _$PosStateImpl>
    implements _$$PosStateImplCopyWith<$Res> {
  __$$PosStateImplCopyWithImpl(
    _$PosStateImpl _value,
    $Res Function(_$PosStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedCategory = null,
    Object? products = null,
    Object? categories = null,
    Object? isLoading = null,
  }) {
    return _then(
      _$PosStateImpl(
        selectedCategory: null == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PosStateImpl implements _PosState {
  const _$PosStateImpl({
    this.selectedCategory = 'Semua',
    final List<Product> products = const [],
    final List<String> categories = const [],
    this.isLoading = false,
  }) : _products = products,
       _categories = categories;

  @override
  @JsonKey()
  final String selectedCategory;
  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'PosState(selectedCategory: $selectedCategory, products: $products, categories: $categories, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PosStateImpl &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedCategory,
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_categories),
    isLoading,
  );

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PosStateImplCopyWith<_$PosStateImpl> get copyWith =>
      __$$PosStateImplCopyWithImpl<_$PosStateImpl>(this, _$identity);
}

abstract class _PosState implements PosState {
  const factory _PosState({
    final String selectedCategory,
    final List<Product> products,
    final List<String> categories,
    final bool isLoading,
  }) = _$PosStateImpl;

  @override
  String get selectedCategory;
  @override
  List<Product> get products;
  @override
  List<String> get categories;
  @override
  bool get isLoading;

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PosStateImplCopyWith<_$PosStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
