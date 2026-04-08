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
  List<ShiftModel> get history => throw _privateConstructorUsedError;
  int get selectedTab =>
      throw _privateConstructorUsedError; // 0: Shift, 1: Absensi
  String? get error => throw _privateConstructorUsedError;
  ShiftSummaryModel? get selectedSummary => throw _privateConstructorUsedError;
  bool get isSummaryLoading => throw _privateConstructorUsedError;

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
  $Res call({
    bool isLoading,
    ShiftModel? activeShift,
    List<ShiftModel> history,
    int selectedTab,
    String? error,
    ShiftSummaryModel? selectedSummary,
    bool isSummaryLoading,
  });

  $ShiftModelCopyWith<$Res>? get activeShift;
  $ShiftSummaryModelCopyWith<$Res>? get selectedSummary;
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
    Object? history = null,
    Object? selectedTab = null,
    Object? error = freezed,
    Object? selectedSummary = freezed,
    Object? isSummaryLoading = null,
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
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<ShiftModel>,
            selectedTab: null == selectedTab
                ? _value.selectedTab
                : selectedTab // ignore: cast_nullable_to_non_nullable
                      as int,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedSummary: freezed == selectedSummary
                ? _value.selectedSummary
                : selectedSummary // ignore: cast_nullable_to_non_nullable
                      as ShiftSummaryModel?,
            isSummaryLoading: null == isSummaryLoading
                ? _value.isSummaryLoading
                : isSummaryLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
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

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShiftSummaryModelCopyWith<$Res>? get selectedSummary {
    if (_value.selectedSummary == null) {
      return null;
    }

    return $ShiftSummaryModelCopyWith<$Res>(_value.selectedSummary!, (value) {
      return _then(_value.copyWith(selectedSummary: value) as $Val);
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
  $Res call({
    bool isLoading,
    ShiftModel? activeShift,
    List<ShiftModel> history,
    int selectedTab,
    String? error,
    ShiftSummaryModel? selectedSummary,
    bool isSummaryLoading,
  });

  @override
  $ShiftModelCopyWith<$Res>? get activeShift;
  @override
  $ShiftSummaryModelCopyWith<$Res>? get selectedSummary;
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
    Object? history = null,
    Object? selectedTab = null,
    Object? error = freezed,
    Object? selectedSummary = freezed,
    Object? isSummaryLoading = null,
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
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<ShiftModel>,
        selectedTab: null == selectedTab
            ? _value.selectedTab
            : selectedTab // ignore: cast_nullable_to_non_nullable
                  as int,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedSummary: freezed == selectedSummary
            ? _value.selectedSummary
            : selectedSummary // ignore: cast_nullable_to_non_nullable
                  as ShiftSummaryModel?,
        isSummaryLoading: null == isSummaryLoading
            ? _value.isSummaryLoading
            : isSummaryLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ShiftStateImpl implements _ShiftState {
  const _$ShiftStateImpl({
    this.isLoading = false,
    this.activeShift,
    final List<ShiftModel> history = const [],
    this.selectedTab = 0,
    this.error,
    this.selectedSummary,
    this.isSummaryLoading = false,
  }) : _history = history;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final ShiftModel? activeShift;
  final List<ShiftModel> _history;
  @override
  @JsonKey()
  List<ShiftModel> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final int selectedTab;
  // 0: Shift, 1: Absensi
  @override
  final String? error;
  @override
  final ShiftSummaryModel? selectedSummary;
  @override
  @JsonKey()
  final bool isSummaryLoading;

  @override
  String toString() {
    return 'ShiftState(isLoading: $isLoading, activeShift: $activeShift, history: $history, selectedTab: $selectedTab, error: $error, selectedSummary: $selectedSummary, isSummaryLoading: $isSummaryLoading)';
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
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.selectedSummary, selectedSummary) ||
                other.selectedSummary == selectedSummary) &&
            (identical(other.isSummaryLoading, isSummaryLoading) ||
                other.isSummaryLoading == isSummaryLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    activeShift,
    const DeepCollectionEquality().hash(_history),
    selectedTab,
    error,
    selectedSummary,
    isSummaryLoading,
  );

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
    final List<ShiftModel> history,
    final int selectedTab,
    final String? error,
    final ShiftSummaryModel? selectedSummary,
    final bool isSummaryLoading,
  }) = _$ShiftStateImpl;

  @override
  bool get isLoading;
  @override
  ShiftModel? get activeShift;
  @override
  List<ShiftModel> get history;
  @override
  int get selectedTab; // 0: Shift, 1: Absensi
  @override
  String? get error;
  @override
  ShiftSummaryModel? get selectedSummary;
  @override
  bool get isSummaryLoading;

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftStateImplCopyWith<_$ShiftStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
