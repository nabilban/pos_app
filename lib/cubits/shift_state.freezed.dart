// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ShiftState {
  bool get isLoading => throw _privateConstructorUsedError;
  ShiftModel? get activeShift => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftStateCopyWith<ShiftState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftStateCopyWith<$Res> {
  factory $ShiftStateCopyWith(
    ShiftState value,
    $Res Function(ShiftState) then,
  ) = _$ShiftStateCopyWithImpl<$Res, ShiftState>;
  @useResult
  $Res call({bool isLoading, ShiftModel? activeShift, String? error});

  $ShiftModelCopyWith<$Res>? get activeShift;
}

/// @nodoc
class _$ShiftStateCopyWithImpl<$Res, $Val extends ShiftState>
    implements $ShiftStateCopyWith<$Res> {
  _$ShiftStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? activeShift = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeShift: freezed == activeShift
                ? _value.activeShift
                : activeShift // ignore: cast_nullable_to_non_nullable
                      as ShiftModel?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShiftModelCopyWith<$Res>? get activeShift {
    if (_value.activeShift == null) {
      return null;
    }

    return $ShiftModelCopyWith<$Res>(_value.activeShift!, (value) {
      return _then(_value.copyWith(activeShift: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShiftStateImplCopyWith<$Res>
    implements $ShiftStateCopyWith<$Res> {
  factory _$$ShiftStateImplCopyWith(
    _$ShiftStateImpl value,
    $Res Function(_$ShiftStateImpl) then,
  ) = __$$ShiftStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, ShiftModel? activeShift, String? error});

  @override
  $ShiftModelCopyWith<$Res>? get activeShift;
}

/// @nodoc
class __$$ShiftStateImplCopyWithImpl<$Res>
    extends _$ShiftStateCopyWithImpl<$Res, _$ShiftStateImpl>
    implements _$$ShiftStateImplCopyWith<$Res> {
  __$$ShiftStateImplCopyWithImpl(
    _$ShiftStateImpl _value,
    $Res Function(_$ShiftStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? activeShift = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$ShiftStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeShift: freezed == activeShift
            ? _value.activeShift
            : activeShift // ignore: cast_nullable_to_non_nullable
                  as ShiftModel?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ShiftStateImpl implements _ShiftState {
  const _$ShiftStateImpl({
    this.isLoading = false,
    this.activeShift,
    this.error,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final ShiftModel? activeShift;
  @override
  final String? error;

  @override
  String toString() {
    return 'ShiftState(isLoading: $isLoading, activeShift: $activeShift, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.activeShift, activeShift) ||
                other.activeShift == activeShift) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, activeShift, error);

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftStateImplCopyWith<_$ShiftStateImpl> get copyWith =>
      __$$ShiftStateImplCopyWithImpl<_$ShiftStateImpl>(this, _$identity);
}

abstract class _ShiftState implements ShiftState {
  const factory _ShiftState({
    final bool isLoading,
    final ShiftModel? activeShift,
    final String? error,
  }) = _$ShiftStateImpl;

  @override
  bool get isLoading;
  @override
  ShiftModel? get activeShift;
  @override
  String? get error;

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftStateImplCopyWith<_$ShiftStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
