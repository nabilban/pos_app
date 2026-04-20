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
  Category? get selectedCategory => throw _privateConstructorUsedError;
  Brand? get selectedBrand => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  List<Category> get categories => throw _privateConstructorUsedError;
  List<Brand> get brands => throw _privateConstructorUsedError;
  List<PaymentMethod> get paymentMethods => throw _privateConstructorUsedError;
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
    Category? selectedCategory,
    Brand? selectedBrand,
    String searchQuery,
    List<Product> products,
    List<Category> categories,
    List<Brand> brands,
    List<PaymentMethod> paymentMethods,
    bool isLoading,
  });

  $CategoryCopyWith<$Res>? get selectedCategory;
  $BrandCopyWith<$Res>? get selectedBrand;
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
    Object? selectedCategory = freezed,
    Object? selectedBrand = freezed,
    Object? searchQuery = null,
    Object? products = null,
    Object? categories = null,
    Object? brands = null,
    Object? paymentMethods = null,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            selectedCategory: freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as Category?,
            selectedBrand: freezed == selectedBrand
                ? _value.selectedBrand
                : selectedBrand // ignore: cast_nullable_to_non_nullable
                      as Brand?,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<Product>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<Category>,
            brands: null == brands
                ? _value.brands
                : brands // ignore: cast_nullable_to_non_nullable
                      as List<Brand>,
            paymentMethods: null == paymentMethods
                ? _value.paymentMethods
                : paymentMethods // ignore: cast_nullable_to_non_nullable
                      as List<PaymentMethod>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get selectedCategory {
    if (_value.selectedCategory == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.selectedCategory!, (value) {
      return _then(_value.copyWith(selectedCategory: value) as $Val);
    });
  }

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandCopyWith<$Res>? get selectedBrand {
    if (_value.selectedBrand == null) {
      return null;
    }

    return $BrandCopyWith<$Res>(_value.selectedBrand!, (value) {
      return _then(_value.copyWith(selectedBrand: value) as $Val);
    });
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
    Category? selectedCategory,
    Brand? selectedBrand,
    String searchQuery,
    List<Product> products,
    List<Category> categories,
    List<Brand> brands,
    List<PaymentMethod> paymentMethods,
    bool isLoading,
  });

  @override
  $CategoryCopyWith<$Res>? get selectedCategory;
  @override
  $BrandCopyWith<$Res>? get selectedBrand;
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
    Object? selectedCategory = freezed,
    Object? selectedBrand = freezed,
    Object? searchQuery = null,
    Object? products = null,
    Object? categories = null,
    Object? brands = null,
    Object? paymentMethods = null,
    Object? isLoading = null,
  }) {
    return _then(
      _$PosStateImpl(
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as Category?,
        selectedBrand: freezed == selectedBrand
            ? _value.selectedBrand
            : selectedBrand // ignore: cast_nullable_to_non_nullable
                  as Brand?,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<Category>,
        brands: null == brands
            ? _value._brands
            : brands // ignore: cast_nullable_to_non_nullable
                  as List<Brand>,
        paymentMethods: null == paymentMethods
            ? _value._paymentMethods
            : paymentMethods // ignore: cast_nullable_to_non_nullable
                  as List<PaymentMethod>,
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
    this.selectedCategory,
    this.selectedBrand,
    this.searchQuery = '',
    final List<Product> products = const [],
    final List<Category> categories = const [],
    final List<Brand> brands = const [],
    final List<PaymentMethod> paymentMethods = const [],
    this.isLoading = false,
  }) : _products = products,
       _categories = categories,
       _brands = brands,
       _paymentMethods = paymentMethods;

  @override
  final Category? selectedCategory;
  @override
  final Brand? selectedBrand;
  @override
  @JsonKey()
  final String searchQuery;
  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Category> _categories;
  @override
  @JsonKey()
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<Brand> _brands;
  @override
  @JsonKey()
  List<Brand> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  final List<PaymentMethod> _paymentMethods;
  @override
  @JsonKey()
  List<PaymentMethod> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'PosState(selectedCategory: $selectedCategory, selectedBrand: $selectedBrand, searchQuery: $searchQuery, products: $products, categories: $categories, brands: $brands, paymentMethods: $paymentMethods, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PosStateImpl &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedBrand, selectedBrand) ||
                other.selectedBrand == selectedBrand) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            const DeepCollectionEquality().equals(
              other._paymentMethods,
              _paymentMethods,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedCategory,
    selectedBrand,
    searchQuery,
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_brands),
    const DeepCollectionEquality().hash(_paymentMethods),
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
    final Category? selectedCategory,
    final Brand? selectedBrand,
    final String searchQuery,
    final List<Product> products,
    final List<Category> categories,
    final List<Brand> brands,
    final List<PaymentMethod> paymentMethods,
    final bool isLoading,
  }) = _$PosStateImpl;

  @override
  Category? get selectedCategory;
  @override
  Brand? get selectedBrand;
  @override
  String get searchQuery;
  @override
  List<Product> get products;
  @override
  List<Category> get categories;
  @override
  List<Brand> get brands;
  @override
  List<PaymentMethod> get paymentMethods;
  @override
  bool get isLoading;

  /// Create a copy of PosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PosStateImplCopyWith<_$PosStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
