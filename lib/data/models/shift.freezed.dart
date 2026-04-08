// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShiftModel _$ShiftModelFromJson(Map<String, dynamic> json) {
  return _ShiftModel.fromJson(json);
}

/// @nodoc
mixin _$ShiftModel {
  @JsonKey(name: 'ID')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_in')
  double get cashIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_out')
  double? get cashOut => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  DateTime get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  DateTime? get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get syncStatus => throw _privateConstructorUsedError;

  /// Serializes this ShiftModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftModelCopyWith<ShiftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftModelCopyWith<$Res> {
  factory $ShiftModelCopyWith(
    ShiftModel value,
    $Res Function(ShiftModel) then,
  ) = _$ShiftModelCopyWithImpl<$Res, ShiftModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int? id,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'cash_in') double cashIn,
    @JsonKey(name: 'cash_out') double? cashOut,
    String? notes,
    @JsonKey(name: 'start_time') DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    String status,
    String syncStatus,
  });
}

/// @nodoc
class _$ShiftModelCopyWithImpl<$Res, $Val extends ShiftModel>
    implements $ShiftModelCopyWith<$Res> {
  _$ShiftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? cashIn = null,
    Object? cashOut = freezed,
    Object? notes = freezed,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? syncStatus = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            cashIn: null == cashIn
                ? _value.cashIn
                : cashIn // ignore: cast_nullable_to_non_nullable
                      as double,
            cashOut: freezed == cashOut
                ? _value.cashOut
                : cashOut // ignore: cast_nullable_to_non_nullable
                      as double?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            syncStatus: null == syncStatus
                ? _value.syncStatus
                : syncStatus // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShiftModelImplCopyWith<$Res>
    implements $ShiftModelCopyWith<$Res> {
  factory _$$ShiftModelImplCopyWith(
    _$ShiftModelImpl value,
    $Res Function(_$ShiftModelImpl) then,
  ) = __$$ShiftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ID') int? id,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'cash_in') double cashIn,
    @JsonKey(name: 'cash_out') double? cashOut,
    String? notes,
    @JsonKey(name: 'start_time') DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    String status,
    String syncStatus,
  });
}

/// @nodoc
class __$$ShiftModelImplCopyWithImpl<$Res>
    extends _$ShiftModelCopyWithImpl<$Res, _$ShiftModelImpl>
    implements _$$ShiftModelImplCopyWith<$Res> {
  __$$ShiftModelImplCopyWithImpl(
    _$ShiftModelImpl _value,
    $Res Function(_$ShiftModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? cashIn = null,
    Object? cashOut = freezed,
    Object? notes = freezed,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? syncStatus = null,
  }) {
    return _then(
      _$ShiftModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        cashIn: null == cashIn
            ? _value.cashIn
            : cashIn // ignore: cast_nullable_to_non_nullable
                  as double,
        cashOut: freezed == cashOut
            ? _value.cashOut
            : cashOut // ignore: cast_nullable_to_non_nullable
                  as double?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        syncStatus: null == syncStatus
            ? _value.syncStatus
            : syncStatus // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftModelImpl implements _ShiftModel {
  const _$ShiftModelImpl({
    @JsonKey(name: 'ID') required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'cash_in') required this.cashIn,
    @JsonKey(name: 'cash_out') this.cashOut,
    this.notes,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') this.endTime,
    this.status = 'open',
    this.syncStatus = 'pending',
  });

  factory _$ShiftModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftModelImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int? id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'cash_in')
  final double cashIn;
  @override
  @JsonKey(name: 'cash_out')
  final double? cashOut;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @override
  @JsonKey(name: 'end_time')
  final DateTime? endTime;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String syncStatus;

  @override
  String toString() {
    return 'ShiftModel(id: $id, userId: $userId, cashIn: $cashIn, cashOut: $cashOut, notes: $notes, startTime: $startTime, endTime: $endTime, status: $status, syncStatus: $syncStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cashIn, cashIn) || other.cashIn == cashIn) &&
            (identical(other.cashOut, cashOut) || other.cashOut == cashOut) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    cashIn,
    cashOut,
    notes,
    startTime,
    endTime,
    status,
    syncStatus,
  );

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftModelImplCopyWith<_$ShiftModelImpl> get copyWith =>
      __$$ShiftModelImplCopyWithImpl<_$ShiftModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftModelImplToJson(this);
  }
}

abstract class _ShiftModel implements ShiftModel {
  const factory _ShiftModel({
    @JsonKey(name: 'ID') required final int? id,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'cash_in') required final double cashIn,
    @JsonKey(name: 'cash_out') final double? cashOut,
    final String? notes,
    @JsonKey(name: 'start_time') required final DateTime startTime,
    @JsonKey(name: 'end_time') final DateTime? endTime,
    final String status,
    final String syncStatus,
  }) = _$ShiftModelImpl;

  factory _ShiftModel.fromJson(Map<String, dynamic> json) =
      _$ShiftModelImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int? get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'cash_in')
  double get cashIn;
  @override
  @JsonKey(name: 'cash_out')
  double? get cashOut;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'start_time')
  DateTime get startTime;
  @override
  @JsonKey(name: 'end_time')
  DateTime? get endTime;
  @override
  String get status;
  @override
  String get syncStatus;

  /// Create a copy of ShiftModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftModelImplCopyWith<_$ShiftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
