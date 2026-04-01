// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckoutState {
  int get currentStep =>
      throw _privateConstructorUsedError; // 0: Confirmation, 1: Payment
  String get selectedMethod => throw _privateConstructorUsedError;
  String get buyerName => throw _privateConstructorUsedError;
  double get cashAmount => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get invoiceNumber => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  int? get selectedPriceCategoryId => throw _privateConstructorUsedError;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
    CheckoutState value,
    $Res Function(CheckoutState) then,
  ) = _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
  @useResult
  $Res call({
    int currentStep,
    String selectedMethod,
    String buyerName,
    double cashAmount,
    bool isProcessing,
    bool success,
    String? invoiceNumber,
    String? error,
    int? selectedPriceCategoryId,
  });
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? selectedMethod = null,
    Object? buyerName = null,
    Object? cashAmount = null,
    Object? isProcessing = null,
    Object? success = null,
    Object? invoiceNumber = freezed,
    Object? error = freezed,
    Object? selectedPriceCategoryId = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedMethod: null == selectedMethod
                ? _value.selectedMethod
                : selectedMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            buyerName: null == buyerName
                ? _value.buyerName
                : buyerName // ignore: cast_nullable_to_non_nullable
                      as String,
            cashAmount: null == cashAmount
                ? _value.cashAmount
                : cashAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            isProcessing: null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                      as bool,
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            invoiceNumber: freezed == invoiceNumber
                ? _value.invoiceNumber
                : invoiceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedPriceCategoryId: freezed == selectedPriceCategoryId
                ? _value.selectedPriceCategoryId
                : selectedPriceCategoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
    _$CheckoutStateImpl value,
    $Res Function(_$CheckoutStateImpl) then,
  ) = __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentStep,
    String selectedMethod,
    String buyerName,
    double cashAmount,
    bool isProcessing,
    bool success,
    String? invoiceNumber,
    String? error,
    int? selectedPriceCategoryId,
  });
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
    _$CheckoutStateImpl _value,
    $Res Function(_$CheckoutStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? selectedMethod = null,
    Object? buyerName = null,
    Object? cashAmount = null,
    Object? isProcessing = null,
    Object? success = null,
    Object? invoiceNumber = freezed,
    Object? error = freezed,
    Object? selectedPriceCategoryId = freezed,
  }) {
    return _then(
      _$CheckoutStateImpl(
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedMethod: null == selectedMethod
            ? _value.selectedMethod
            : selectedMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        buyerName: null == buyerName
            ? _value.buyerName
            : buyerName // ignore: cast_nullable_to_non_nullable
                  as String,
        cashAmount: null == cashAmount
            ? _value.cashAmount
            : cashAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        isProcessing: null == isProcessing
            ? _value.isProcessing
            : isProcessing // ignore: cast_nullable_to_non_nullable
                  as bool,
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        invoiceNumber: freezed == invoiceNumber
            ? _value.invoiceNumber
            : invoiceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedPriceCategoryId: freezed == selectedPriceCategoryId
            ? _value.selectedPriceCategoryId
            : selectedPriceCategoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl({
    this.currentStep = 0,
    this.selectedMethod = 'Cash',
    this.buyerName = '',
    this.cashAmount = 0.0,
    this.isProcessing = false,
    this.success = false,
    this.invoiceNumber,
    this.error,
    this.selectedPriceCategoryId,
  });

  @override
  @JsonKey()
  final int currentStep;
  // 0: Confirmation, 1: Payment
  @override
  @JsonKey()
  final String selectedMethod;
  @override
  @JsonKey()
  final String buyerName;
  @override
  @JsonKey()
  final double cashAmount;
  @override
  @JsonKey()
  final bool isProcessing;
  @override
  @JsonKey()
  final bool success;
  @override
  final String? invoiceNumber;
  @override
  final String? error;
  @override
  final int? selectedPriceCategoryId;

  @override
  String toString() {
    return 'CheckoutState(currentStep: $currentStep, selectedMethod: $selectedMethod, buyerName: $buyerName, cashAmount: $cashAmount, isProcessing: $isProcessing, success: $success, invoiceNumber: $invoiceNumber, error: $error, selectedPriceCategoryId: $selectedPriceCategoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.selectedMethod, selectedMethod) ||
                other.selectedMethod == selectedMethod) &&
            (identical(other.buyerName, buyerName) ||
                other.buyerName == buyerName) &&
            (identical(other.cashAmount, cashAmount) ||
                other.cashAmount == cashAmount) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(
                  other.selectedPriceCategoryId,
                  selectedPriceCategoryId,
                ) ||
                other.selectedPriceCategoryId == selectedPriceCategoryId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentStep,
    selectedMethod,
    buyerName,
    cashAmount,
    isProcessing,
    success,
    invoiceNumber,
    error,
    selectedPriceCategoryId,
  );

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState implements CheckoutState {
  const factory _CheckoutState({
    final int currentStep,
    final String selectedMethod,
    final String buyerName,
    final double cashAmount,
    final bool isProcessing,
    final bool success,
    final String? invoiceNumber,
    final String? error,
    final int? selectedPriceCategoryId,
  }) = _$CheckoutStateImpl;

  @override
  int get currentStep; // 0: Confirmation, 1: Payment
  @override
  String get selectedMethod;
  @override
  String get buyerName;
  @override
  double get cashAmount;
  @override
  bool get isProcessing;
  @override
  bool get success;
  @override
  String? get invoiceNumber;
  @override
  String? get error;
  @override
  int? get selectedPriceCategoryId;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
