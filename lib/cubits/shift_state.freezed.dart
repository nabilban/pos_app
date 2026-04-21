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
  AttendanceModel? get todayAttendance => throw _privateConstructorUsedError;
  List<AttendanceModel> get attendanceHistory =>
      throw _privateConstructorUsedError;
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
  $Res call({
    bool isLoading,
    ShiftModel? activeShift,
    List<ShiftModel> history,
    int selectedTab,
    AttendanceModel? todayAttendance,
    List<AttendanceModel> attendanceHistory,
    String? error,
  });

  $ShiftModelCopyWith<$Res>? get activeShift;
  $AttendanceModelCopyWith<$Res>? get todayAttendance;
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
    Object? todayAttendance = freezed,
    Object? attendanceHistory = null,
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
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<ShiftModel>,
            selectedTab: null == selectedTab
                ? _value.selectedTab
                : selectedTab // ignore: cast_nullable_to_non_nullable
                      as int,
            todayAttendance: freezed == todayAttendance
                ? _value.todayAttendance
                : todayAttendance // ignore: cast_nullable_to_non_nullable
                      as AttendanceModel?,
            attendanceHistory: null == attendanceHistory
                ? _value.attendanceHistory
                : attendanceHistory // ignore: cast_nullable_to_non_nullable
                      as List<AttendanceModel>,
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

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AttendanceModelCopyWith<$Res>? get todayAttendance {
    if (_value.todayAttendance == null) {
      return null;
    }

    return $AttendanceModelCopyWith<$Res>(_value.todayAttendance!, (value) {
      return _then(_value.copyWith(todayAttendance: value) as $Val);
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
    AttendanceModel? todayAttendance,
    List<AttendanceModel> attendanceHistory,
    String? error,
  });

  @override
  $ShiftModelCopyWith<$Res>? get activeShift;
  @override
  $AttendanceModelCopyWith<$Res>? get todayAttendance;
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
    Object? todayAttendance = freezed,
    Object? attendanceHistory = null,
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
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<ShiftModel>,
        selectedTab: null == selectedTab
            ? _value.selectedTab
            : selectedTab // ignore: cast_nullable_to_non_nullable
                  as int,
        todayAttendance: freezed == todayAttendance
            ? _value.todayAttendance
            : todayAttendance // ignore: cast_nullable_to_non_nullable
                  as AttendanceModel?,
        attendanceHistory: null == attendanceHistory
            ? _value._attendanceHistory
            : attendanceHistory // ignore: cast_nullable_to_non_nullable
                  as List<AttendanceModel>,
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
    final List<ShiftModel> history = const [],
    this.selectedTab = 0,
    this.todayAttendance,
    final List<AttendanceModel> attendanceHistory = const [],
    this.error,
  }) : _history = history,
       _attendanceHistory = attendanceHistory;

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
  final AttendanceModel? todayAttendance;
  final List<AttendanceModel> _attendanceHistory;
  @override
  @JsonKey()
  List<AttendanceModel> get attendanceHistory {
    if (_attendanceHistory is EqualUnmodifiableListView)
      return _attendanceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendanceHistory);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'ShiftState(isLoading: $isLoading, activeShift: $activeShift, history: $history, selectedTab: $selectedTab, todayAttendance: $todayAttendance, attendanceHistory: $attendanceHistory, error: $error)';
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
            (identical(other.todayAttendance, todayAttendance) ||
                other.todayAttendance == todayAttendance) &&
            const DeepCollectionEquality().equals(
              other._attendanceHistory,
              _attendanceHistory,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    activeShift,
    const DeepCollectionEquality().hash(_history),
    selectedTab,
    todayAttendance,
    const DeepCollectionEquality().hash(_attendanceHistory),
    error,
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
    final AttendanceModel? todayAttendance,
    final List<AttendanceModel> attendanceHistory,
    final String? error,
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
  AttendanceModel? get todayAttendance;
  @override
  List<AttendanceModel> get attendanceHistory;
  @override
  String? get error;

  /// Create a copy of ShiftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftStateImplCopyWith<_$ShiftStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
