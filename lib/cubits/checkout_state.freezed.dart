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
  String get selectedPaymentMethod => throw _privateConstructorUsedError;
  double get cashAmount => throw _privateConstructorUsedError;

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
  $Res call({String selectedPaymentMethod, double cashAmount});
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
  $Res call({Object? selectedPaymentMethod = null, Object? cashAmount = null}) {
    return _then(
      _value.copyWith(
            selectedPaymentMethod: null == selectedPaymentMethod
                ? _value.selectedPaymentMethod
                : selectedPaymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            cashAmount: null == cashAmount
                ? _value.cashAmount
                : cashAmount // ignore: cast_nullable_to_non_nullable
                      as double,
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
  $Res call({String selectedPaymentMethod, double cashAmount});
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
  $Res call({Object? selectedPaymentMethod = null, Object? cashAmount = null}) {
    return _then(
      _$CheckoutStateImpl(
        selectedPaymentMethod: null == selectedPaymentMethod
            ? _value.selectedPaymentMethod
            : selectedPaymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        cashAmount: null == cashAmount
            ? _value.cashAmount
            : cashAmount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl({
    this.selectedPaymentMethod = '',
    this.cashAmount = 0.0,
  });

  @override
  @JsonKey()
  final String selectedPaymentMethod;
  @override
  @JsonKey()
  final double cashAmount;

  @override
  String toString() {
    return 'CheckoutState(selectedPaymentMethod: $selectedPaymentMethod, cashAmount: $cashAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.selectedPaymentMethod, selectedPaymentMethod) ||
                other.selectedPaymentMethod == selectedPaymentMethod) &&
            (identical(other.cashAmount, cashAmount) ||
                other.cashAmount == cashAmount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedPaymentMethod, cashAmount);

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
    final String selectedPaymentMethod,
    final double cashAmount,
  }) = _$CheckoutStateImpl;

  @override
  String get selectedPaymentMethod;
  @override
  double get cashAmount;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
