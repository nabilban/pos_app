// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'CreatedAt')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_number')
  String get invoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method_id')
  int get paymentMethodId => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_total')
  double get discountTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'manual_discount')
  double get manualDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_fee')
  double get additionalFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double get grandTotal => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  SaleUser? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  List<SaleItem> get items => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'invoice_number') String invoiceNumber,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'payment_method_id') int paymentMethodId,
    double subtotal,
    @JsonKey(name: 'discount_total') double discountTotal,
    @JsonKey(name: 'manual_discount') double manualDiscount,
    @JsonKey(name: 'additional_fee') double additionalFee,
    @JsonKey(name: 'grand_total') double grandTotal,
    String source,
    SaleUser? user,
    @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
    List<SaleItem> items,
  });

  $SaleUserCopyWith<$Res>? get user;
  $PaymentMethodCopyWith<$Res>? get paymentMethod;
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? invoiceNumber = null,
    Object? customerName = null,
    Object? paymentMethodId = null,
    Object? subtotal = null,
    Object? discountTotal = null,
    Object? manualDiscount = null,
    Object? additionalFee = null,
    Object? grandTotal = null,
    Object? source = null,
    Object? user = freezed,
    Object? paymentMethod = freezed,
    Object? items = null,
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
            invoiceNumber: null == invoiceNumber
                ? _value.invoiceNumber
                : invoiceNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethodId: null == paymentMethodId
                ? _value.paymentMethodId
                : paymentMethodId // ignore: cast_nullable_to_non_nullable
                      as int,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            discountTotal: null == discountTotal
                ? _value.discountTotal
                : discountTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            manualDiscount: null == manualDiscount
                ? _value.manualDiscount
                : manualDiscount // ignore: cast_nullable_to_non_nullable
                      as double,
            additionalFee: null == additionalFee
                ? _value.additionalFee
                : additionalFee // ignore: cast_nullable_to_non_nullable
                      as double,
            grandTotal: null == grandTotal
                ? _value.grandTotal
                : grandTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as SaleUser?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<SaleItem>,
          )
          as $Val,
    );
  }

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $SaleUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res>? get paymentMethod {
    if (_value.paymentMethod == null) {
      return null;
    }

    return $PaymentMethodCopyWith<$Res>(_value.paymentMethod!, (value) {
      return _then(_value.copyWith(paymentMethod: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
    _$SaleImpl value,
    $Res Function(_$SaleImpl) then,
  ) = __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'CreatedAt') String createdAt,
    @JsonKey(name: 'invoice_number') String invoiceNumber,
    @JsonKey(name: 'customer_name') String customerName,
    @JsonKey(name: 'payment_method_id') int paymentMethodId,
    double subtotal,
    @JsonKey(name: 'discount_total') double discountTotal,
    @JsonKey(name: 'manual_discount') double manualDiscount,
    @JsonKey(name: 'additional_fee') double additionalFee,
    @JsonKey(name: 'grand_total') double grandTotal,
    String source,
    SaleUser? user,
    @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
    List<SaleItem> items,
  });

  @override
  $SaleUserCopyWith<$Res>? get user;
  @override
  $PaymentMethodCopyWith<$Res>? get paymentMethod;
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
    : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? invoiceNumber = null,
    Object? customerName = null,
    Object? paymentMethodId = null,
    Object? subtotal = null,
    Object? discountTotal = null,
    Object? manualDiscount = null,
    Object? additionalFee = null,
    Object? grandTotal = null,
    Object? source = null,
    Object? user = freezed,
    Object? paymentMethod = freezed,
    Object? items = null,
  }) {
    return _then(
      _$SaleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        invoiceNumber: null == invoiceNumber
            ? _value.invoiceNumber
            : invoiceNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethodId: null == paymentMethodId
            ? _value.paymentMethodId
            : paymentMethodId // ignore: cast_nullable_to_non_nullable
                  as int,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        discountTotal: null == discountTotal
            ? _value.discountTotal
            : discountTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        manualDiscount: null == manualDiscount
            ? _value.manualDiscount
            : manualDiscount // ignore: cast_nullable_to_non_nullable
                  as double,
        additionalFee: null == additionalFee
            ? _value.additionalFee
            : additionalFee // ignore: cast_nullable_to_non_nullable
                  as double,
        grandTotal: null == grandTotal
            ? _value.grandTotal
            : grandTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as SaleUser?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<SaleItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl implements _Sale {
  const _$SaleImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'CreatedAt') required this.createdAt,
    @JsonKey(name: 'invoice_number') required this.invoiceNumber,
    @JsonKey(name: 'customer_name') this.customerName = '',
    @JsonKey(name: 'payment_method_id') required this.paymentMethodId,
    this.subtotal = 0,
    @JsonKey(name: 'discount_total') this.discountTotal = 0,
    @JsonKey(name: 'manual_discount') this.manualDiscount = 0,
    @JsonKey(name: 'additional_fee') this.additionalFee = 0,
    @JsonKey(name: 'grand_total') this.grandTotal = 0,
    this.source = 'pos',
    this.user,
    @JsonKey(name: 'payment_method') this.paymentMethod,
    final List<SaleItem> items = const [],
  }) : _items = items;

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey(name: 'CreatedAt')
  final String createdAt;
  @override
  @JsonKey(name: 'invoice_number')
  final String invoiceNumber;
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  @JsonKey(name: 'payment_method_id')
  final int paymentMethodId;
  @override
  @JsonKey()
  final double subtotal;
  @override
  @JsonKey(name: 'discount_total')
  final double discountTotal;
  @override
  @JsonKey(name: 'manual_discount')
  final double manualDiscount;
  @override
  @JsonKey(name: 'additional_fee')
  final double additionalFee;
  @override
  @JsonKey(name: 'grand_total')
  final double grandTotal;
  @override
  @JsonKey()
  final String source;
  @override
  final SaleUser? user;
  @override
  @JsonKey(name: 'payment_method')
  final PaymentMethod? paymentMethod;
  final List<SaleItem> _items;
  @override
  @JsonKey()
  List<SaleItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'Sale(id: $id, createdAt: $createdAt, invoiceNumber: $invoiceNumber, customerName: $customerName, paymentMethodId: $paymentMethodId, subtotal: $subtotal, discountTotal: $discountTotal, manualDiscount: $manualDiscount, additionalFee: $additionalFee, grandTotal: $grandTotal, source: $source, user: $user, paymentMethod: $paymentMethod, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discountTotal, discountTotal) ||
                other.discountTotal == discountTotal) &&
            (identical(other.manualDiscount, manualDiscount) ||
                other.manualDiscount == manualDiscount) &&
            (identical(other.additionalFee, additionalFee) ||
                other.additionalFee == additionalFee) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAt,
    invoiceNumber,
    customerName,
    paymentMethodId,
    subtotal,
    discountTotal,
    manualDiscount,
    additionalFee,
    grandTotal,
    source,
    user,
    paymentMethod,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(this);
  }
}

abstract class _Sale implements Sale {
  const factory _Sale({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'CreatedAt') required final String createdAt,
    @JsonKey(name: 'invoice_number') required final String invoiceNumber,
    @JsonKey(name: 'customer_name') final String customerName,
    @JsonKey(name: 'payment_method_id') required final int paymentMethodId,
    final double subtotal,
    @JsonKey(name: 'discount_total') final double discountTotal,
    @JsonKey(name: 'manual_discount') final double manualDiscount,
    @JsonKey(name: 'additional_fee') final double additionalFee,
    @JsonKey(name: 'grand_total') final double grandTotal,
    final String source,
    final SaleUser? user,
    @JsonKey(name: 'payment_method') final PaymentMethod? paymentMethod,
    final List<SaleItem> items,
  }) = _$SaleImpl;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  @JsonKey(name: 'CreatedAt')
  String get createdAt;
  @override
  @JsonKey(name: 'invoice_number')
  String get invoiceNumber;
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  @JsonKey(name: 'payment_method_id')
  int get paymentMethodId;
  @override
  double get subtotal;
  @override
  @JsonKey(name: 'discount_total')
  double get discountTotal;
  @override
  @JsonKey(name: 'manual_discount')
  double get manualDiscount;
  @override
  @JsonKey(name: 'additional_fee')
  double get additionalFee;
  @override
  @JsonKey(name: 'grand_total')
  double get grandTotal;
  @override
  String get source;
  @override
  SaleUser? get user;
  @override
  @JsonKey(name: 'payment_method')
  PaymentMethod? get paymentMethod;
  @override
  List<SaleItem> get items;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleUser _$SaleUserFromJson(Map<String, dynamic> json) {
  return _SaleUser.fromJson(json);
}

/// @nodoc
mixin _$SaleUser {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  /// Serializes this SaleUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleUserCopyWith<SaleUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleUserCopyWith<$Res> {
  factory $SaleUserCopyWith(SaleUser value, $Res Function(SaleUser) then) =
      _$SaleUserCopyWithImpl<$Res, SaleUser>;
  @useResult
  $Res call({@JsonKey(name: 'ID') int id, String name, String username});
}

/// @nodoc
class _$SaleUserCopyWithImpl<$Res, $Val extends SaleUser>
    implements $SaleUserCopyWith<$Res> {
  _$SaleUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? username = null}) {
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
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleUserImplCopyWith<$Res>
    implements $SaleUserCopyWith<$Res> {
  factory _$$SaleUserImplCopyWith(
    _$SaleUserImpl value,
    $Res Function(_$SaleUserImpl) then,
  ) = __$$SaleUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'ID') int id, String name, String username});
}

/// @nodoc
class __$$SaleUserImplCopyWithImpl<$Res>
    extends _$SaleUserCopyWithImpl<$Res, _$SaleUserImpl>
    implements _$$SaleUserImplCopyWith<$Res> {
  __$$SaleUserImplCopyWithImpl(
    _$SaleUserImpl _value,
    $Res Function(_$SaleUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? username = null}) {
    return _then(
      _$SaleUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleUserImpl implements _SaleUser {
  const _$SaleUserImpl({
    @JsonKey(name: 'ID') required this.id,
    this.name = '',
    this.username = '',
  });

  factory _$SaleUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleUserImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String username;

  @override
  String toString() {
    return 'SaleUser(id: $id, name: $name, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, username);

  /// Create a copy of SaleUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleUserImplCopyWith<_$SaleUserImpl> get copyWith =>
      __$$SaleUserImplCopyWithImpl<_$SaleUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleUserImplToJson(this);
  }
}

abstract class _SaleUser implements SaleUser {
  const factory _SaleUser({
    @JsonKey(name: 'ID') required final int id,
    final String name,
    final String username,
  }) = _$SaleUserImpl;

  factory _SaleUser.fromJson(Map<String, dynamic> json) =
      _$SaleUserImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  String get name;
  @override
  String get username;

  /// Create a copy of SaleUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleUserImplCopyWith<_$SaleUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItem _$SaleItemFromJson(Map<String, dynamic> json) {
  return _SaleItem.fromJson(json);
}

/// @nodoc
mixin _$SaleItem {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_price')
  double get basePrice => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  SaleProduct? get product => throw _privateConstructorUsedError;
  List<SaleItemVariant> get variants => throw _privateConstructorUsedError;

  /// Serializes this SaleItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemCopyWith<SaleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemCopyWith<$Res> {
  factory $SaleItemCopyWith(SaleItem value, $Res Function(SaleItem) then) =
      _$SaleItemCopyWithImpl<$Res, SaleItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'product_id') int productId,
    int quantity,
    @JsonKey(name: 'base_price') double basePrice,
    double discount,
    double subtotal,
    SaleProduct? product,
    List<SaleItemVariant> variants,
  });

  $SaleProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$SaleItemCopyWithImpl<$Res, $Val extends SaleItem>
    implements $SaleItemCopyWith<$Res> {
  _$SaleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? quantity = null,
    Object? basePrice = null,
    Object? discount = null,
    Object? subtotal = null,
    Object? product = freezed,
    Object? variants = null,
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
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as double,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as SaleProduct?,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<SaleItemVariant>,
          )
          as $Val,
    );
  }

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $SaleProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleItemImplCopyWith<$Res>
    implements $SaleItemCopyWith<$Res> {
  factory _$$SaleItemImplCopyWith(
    _$SaleItemImpl value,
    $Res Function(_$SaleItemImpl) then,
  ) = __$$SaleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'product_id') int productId,
    int quantity,
    @JsonKey(name: 'base_price') double basePrice,
    double discount,
    double subtotal,
    SaleProduct? product,
    List<SaleItemVariant> variants,
  });

  @override
  $SaleProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$SaleItemImplCopyWithImpl<$Res>
    extends _$SaleItemCopyWithImpl<$Res, _$SaleItemImpl>
    implements _$$SaleItemImplCopyWith<$Res> {
  __$$SaleItemImplCopyWithImpl(
    _$SaleItemImpl _value,
    $Res Function(_$SaleItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? quantity = null,
    Object? basePrice = null,
    Object? discount = null,
    Object? subtotal = null,
    Object? product = freezed,
    Object? variants = null,
  }) {
    return _then(
      _$SaleItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as double,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as SaleProduct?,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<SaleItemVariant>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleItemImpl implements _SaleItem {
  const _$SaleItemImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'product_id') required this.productId,
    this.quantity = 1,
    @JsonKey(name: 'base_price') this.basePrice = 0,
    this.discount = 0,
    this.subtotal = 0,
    this.product,
    final List<SaleItemVariant> variants = const [],
  }) : _variants = variants;

  factory _$SaleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey(name: 'base_price')
  final double basePrice;
  @override
  @JsonKey()
  final double discount;
  @override
  @JsonKey()
  final double subtotal;
  @override
  final SaleProduct? product;
  final List<SaleItemVariant> _variants;
  @override
  @JsonKey()
  List<SaleItemVariant> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'SaleItem(id: $id, productId: $productId, quantity: $quantity, basePrice: $basePrice, discount: $discount, subtotal: $subtotal, product: $product, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    quantity,
    basePrice,
    discount,
    subtotal,
    product,
    const DeepCollectionEquality().hash(_variants),
  );

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemImplCopyWith<_$SaleItemImpl> get copyWith =>
      __$$SaleItemImplCopyWithImpl<_$SaleItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemImplToJson(this);
  }
}

abstract class _SaleItem implements SaleItem {
  const factory _SaleItem({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'product_id') required final int productId,
    final int quantity,
    @JsonKey(name: 'base_price') final double basePrice,
    final double discount,
    final double subtotal,
    final SaleProduct? product,
    final List<SaleItemVariant> variants,
  }) = _$SaleItemImpl;

  factory _SaleItem.fromJson(Map<String, dynamic> json) =
      _$SaleItemImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'base_price')
  double get basePrice;
  @override
  double get discount;
  @override
  double get subtotal;
  @override
  SaleProduct? get product;
  @override
  List<SaleItemVariant> get variants;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemImplCopyWith<_$SaleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleProduct _$SaleProductFromJson(Map<String, dynamic> json) {
  return _SaleProduct.fromJson(json);
}

/// @nodoc
mixin _$SaleProduct {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  /// Serializes this SaleProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleProductCopyWith<SaleProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleProductCopyWith<$Res> {
  factory $SaleProductCopyWith(
    SaleProduct value,
    $Res Function(SaleProduct) then,
  ) = _$SaleProductCopyWithImpl<$Res, SaleProduct>;
  @useResult
  $Res call({@JsonKey(name: 'ID') int id, String name, double price});
}

/// @nodoc
class _$SaleProductCopyWithImpl<$Res, $Val extends SaleProduct>
    implements $SaleProductCopyWith<$Res> {
  _$SaleProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? price = null}) {
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
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleProductImplCopyWith<$Res>
    implements $SaleProductCopyWith<$Res> {
  factory _$$SaleProductImplCopyWith(
    _$SaleProductImpl value,
    $Res Function(_$SaleProductImpl) then,
  ) = __$$SaleProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'ID') int id, String name, double price});
}

/// @nodoc
class __$$SaleProductImplCopyWithImpl<$Res>
    extends _$SaleProductCopyWithImpl<$Res, _$SaleProductImpl>
    implements _$$SaleProductImplCopyWith<$Res> {
  __$$SaleProductImplCopyWithImpl(
    _$SaleProductImpl _value,
    $Res Function(_$SaleProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? price = null}) {
    return _then(
      _$SaleProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleProductImpl implements _SaleProduct {
  const _$SaleProductImpl({
    @JsonKey(name: 'ID') required this.id,
    this.name = '',
    this.price = 0,
  });

  factory _$SaleProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleProductImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double price;

  @override
  String toString() {
    return 'SaleProduct(id: $id, name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price);

  /// Create a copy of SaleProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleProductImplCopyWith<_$SaleProductImpl> get copyWith =>
      __$$SaleProductImplCopyWithImpl<_$SaleProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleProductImplToJson(this);
  }
}

abstract class _SaleProduct implements SaleProduct {
  const factory _SaleProduct({
    @JsonKey(name: 'ID') required final int id,
    final String name,
    final double price,
  }) = _$SaleProductImpl;

  factory _SaleProduct.fromJson(Map<String, dynamic> json) =
      _$SaleProductImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  String get name;
  @override
  double get price;

  /// Create a copy of SaleProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleProductImplCopyWith<_$SaleProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItemVariant _$SaleItemVariantFromJson(Map<String, dynamic> json) {
  return _SaleItemVariant.fromJson(json);
}

/// @nodoc
mixin _$SaleItemVariant {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_price')
  double get additionalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_option')
  SaleVariantOption? get variantOption => throw _privateConstructorUsedError;

  /// Serializes this SaleItemVariant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleItemVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemVariantCopyWith<SaleItemVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemVariantCopyWith<$Res> {
  factory $SaleItemVariantCopyWith(
    SaleItemVariant value,
    $Res Function(SaleItemVariant) then,
  ) = _$SaleItemVariantCopyWithImpl<$Res, SaleItemVariant>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'additional_price') double additionalPrice,
    @JsonKey(name: 'variant_option') SaleVariantOption? variantOption,
  });

  $SaleVariantOptionCopyWith<$Res>? get variantOption;
}

/// @nodoc
class _$SaleItemVariantCopyWithImpl<$Res, $Val extends SaleItemVariant>
    implements $SaleItemVariantCopyWith<$Res> {
  _$SaleItemVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItemVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? additionalPrice = null,
    Object? variantOption = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            additionalPrice: null == additionalPrice
                ? _value.additionalPrice
                : additionalPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            variantOption: freezed == variantOption
                ? _value.variantOption
                : variantOption // ignore: cast_nullable_to_non_nullable
                      as SaleVariantOption?,
          )
          as $Val,
    );
  }

  /// Create a copy of SaleItemVariant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleVariantOptionCopyWith<$Res>? get variantOption {
    if (_value.variantOption == null) {
      return null;
    }

    return $SaleVariantOptionCopyWith<$Res>(_value.variantOption!, (value) {
      return _then(_value.copyWith(variantOption: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleItemVariantImplCopyWith<$Res>
    implements $SaleItemVariantCopyWith<$Res> {
  factory _$$SaleItemVariantImplCopyWith(
    _$SaleItemVariantImpl value,
    $Res Function(_$SaleItemVariantImpl) then,
  ) = __$$SaleItemVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    @JsonKey(name: 'additional_price') double additionalPrice,
    @JsonKey(name: 'variant_option') SaleVariantOption? variantOption,
  });

  @override
  $SaleVariantOptionCopyWith<$Res>? get variantOption;
}

/// @nodoc
class __$$SaleItemVariantImplCopyWithImpl<$Res>
    extends _$SaleItemVariantCopyWithImpl<$Res, _$SaleItemVariantImpl>
    implements _$$SaleItemVariantImplCopyWith<$Res> {
  __$$SaleItemVariantImplCopyWithImpl(
    _$SaleItemVariantImpl _value,
    $Res Function(_$SaleItemVariantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleItemVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? additionalPrice = null,
    Object? variantOption = freezed,
  }) {
    return _then(
      _$SaleItemVariantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        additionalPrice: null == additionalPrice
            ? _value.additionalPrice
            : additionalPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        variantOption: freezed == variantOption
            ? _value.variantOption
            : variantOption // ignore: cast_nullable_to_non_nullable
                  as SaleVariantOption?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleItemVariantImpl implements _SaleItemVariant {
  const _$SaleItemVariantImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'additional_price') this.additionalPrice = 0,
    @JsonKey(name: 'variant_option') this.variantOption,
  });

  factory _$SaleItemVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemVariantImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey(name: 'additional_price')
  final double additionalPrice;
  @override
  @JsonKey(name: 'variant_option')
  final SaleVariantOption? variantOption;

  @override
  String toString() {
    return 'SaleItemVariant(id: $id, additionalPrice: $additionalPrice, variantOption: $variantOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemVariantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.additionalPrice, additionalPrice) ||
                other.additionalPrice == additionalPrice) &&
            (identical(other.variantOption, variantOption) ||
                other.variantOption == variantOption));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, additionalPrice, variantOption);

  /// Create a copy of SaleItemVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemVariantImplCopyWith<_$SaleItemVariantImpl> get copyWith =>
      __$$SaleItemVariantImplCopyWithImpl<_$SaleItemVariantImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemVariantImplToJson(this);
  }
}

abstract class _SaleItemVariant implements SaleItemVariant {
  const factory _SaleItemVariant({
    @JsonKey(name: 'ID') required final int id,
    @JsonKey(name: 'additional_price') final double additionalPrice,
    @JsonKey(name: 'variant_option') final SaleVariantOption? variantOption,
  }) = _$SaleItemVariantImpl;

  factory _SaleItemVariant.fromJson(Map<String, dynamic> json) =
      _$SaleItemVariantImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  @JsonKey(name: 'additional_price')
  double get additionalPrice;
  @override
  @JsonKey(name: 'variant_option')
  SaleVariantOption? get variantOption;

  /// Create a copy of SaleItemVariant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemVariantImplCopyWith<_$SaleItemVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleVariantOption _$SaleVariantOptionFromJson(Map<String, dynamic> json) {
  return _SaleVariantOption.fromJson(json);
}

/// @nodoc
mixin _$SaleVariantOption {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_price')
  double get additionalPrice => throw _privateConstructorUsedError;

  /// Serializes this SaleVariantOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleVariantOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleVariantOptionCopyWith<SaleVariantOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleVariantOptionCopyWith<$Res> {
  factory $SaleVariantOptionCopyWith(
    SaleVariantOption value,
    $Res Function(SaleVariantOption) then,
  ) = _$SaleVariantOptionCopyWithImpl<$Res, SaleVariantOption>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    String name,
    @JsonKey(name: 'additional_price') double additionalPrice,
  });
}

/// @nodoc
class _$SaleVariantOptionCopyWithImpl<$Res, $Val extends SaleVariantOption>
    implements $SaleVariantOptionCopyWith<$Res> {
  _$SaleVariantOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleVariantOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? additionalPrice = null,
  }) {
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
abstract class _$$SaleVariantOptionImplCopyWith<$Res>
    implements $SaleVariantOptionCopyWith<$Res> {
  factory _$$SaleVariantOptionImplCopyWith(
    _$SaleVariantOptionImpl value,
    $Res Function(_$SaleVariantOptionImpl) then,
  ) = __$$SaleVariantOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int id,
    String name,
    @JsonKey(name: 'additional_price') double additionalPrice,
  });
}

/// @nodoc
class __$$SaleVariantOptionImplCopyWithImpl<$Res>
    extends _$SaleVariantOptionCopyWithImpl<$Res, _$SaleVariantOptionImpl>
    implements _$$SaleVariantOptionImplCopyWith<$Res> {
  __$$SaleVariantOptionImplCopyWithImpl(
    _$SaleVariantOptionImpl _value,
    $Res Function(_$SaleVariantOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleVariantOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? additionalPrice = null,
  }) {
    return _then(
      _$SaleVariantOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
class _$SaleVariantOptionImpl implements _SaleVariantOption {
  const _$SaleVariantOptionImpl({
    @JsonKey(name: 'ID') required this.id,
    this.name = '',
    @JsonKey(name: 'additional_price') this.additionalPrice = 0,
  });

  factory _$SaleVariantOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleVariantOptionImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'additional_price')
  final double additionalPrice;

  @override
  String toString() {
    return 'SaleVariantOption(id: $id, name: $name, additionalPrice: $additionalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleVariantOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.additionalPrice, additionalPrice) ||
                other.additionalPrice == additionalPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, additionalPrice);

  /// Create a copy of SaleVariantOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleVariantOptionImplCopyWith<_$SaleVariantOptionImpl> get copyWith =>
      __$$SaleVariantOptionImplCopyWithImpl<_$SaleVariantOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleVariantOptionImplToJson(this);
  }
}

abstract class _SaleVariantOption implements SaleVariantOption {
  const factory _SaleVariantOption({
    @JsonKey(name: 'ID') required final int id,
    final String name,
    @JsonKey(name: 'additional_price') final double additionalPrice,
  }) = _$SaleVariantOptionImpl;

  factory _SaleVariantOption.fromJson(Map<String, dynamic> json) =
      _$SaleVariantOptionImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'additional_price')
  double get additionalPrice;

  /// Create a copy of SaleVariantOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleVariantOptionImplCopyWith<_$SaleVariantOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
