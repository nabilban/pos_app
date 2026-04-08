// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShiftSummaryModel _$ShiftSummaryModelFromJson(Map<String, dynamic> json) {
  return _ShiftSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$ShiftSummaryModel {
  ShiftModel get shift => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales')
  double get totalSales => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_trx')
  int get totalTrx => throw _privateConstructorUsedError;

  /// Serializes this ShiftSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftSummaryModelCopyWith<ShiftSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftSummaryModelCopyWith<$Res> {
  factory $ShiftSummaryModelCopyWith(
    ShiftSummaryModel value,
    $Res Function(ShiftSummaryModel) then,
  ) = _$ShiftSummaryModelCopyWithImpl<$Res, ShiftSummaryModel>;
  @useResult
  $Res call({
    ShiftModel shift,
    @JsonKey(name: 'total_sales') double totalSales,
    @JsonKey(name: 'total_trx') int totalTrx,
  });

  $ShiftModelCopyWith<$Res> get shift;
}

/// @nodoc
class _$ShiftSummaryModelCopyWithImpl<$Res, $Val extends ShiftSummaryModel>
    implements $ShiftSummaryModelCopyWith<$Res> {
  _$ShiftSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shift = null,
    Object? totalSales = null,
    Object? totalTrx = null,
  }) {
    return _then(
      _value.copyWith(
            shift: null == shift
                ? _value.shift
                : shift // ignore: cast_nullable_to_non_nullable
                      as ShiftModel,
            totalSales: null == totalSales
                ? _value.totalSales
                : totalSales // ignore: cast_nullable_to_non_nullable
                      as double,
            totalTrx: null == totalTrx
                ? _value.totalTrx
                : totalTrx // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ShiftSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShiftModelCopyWith<$Res> get shift {
    return $ShiftModelCopyWith<$Res>(_value.shift, (value) {
      return _then(_value.copyWith(shift: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShiftSummaryModelImplCopyWith<$Res>
    implements $ShiftSummaryModelCopyWith<$Res> {
  factory _$$ShiftSummaryModelImplCopyWith(
    _$ShiftSummaryModelImpl value,
    $Res Function(_$ShiftSummaryModelImpl) then,
  ) = __$$ShiftSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ShiftModel shift,
    @JsonKey(name: 'total_sales') double totalSales,
    @JsonKey(name: 'total_trx') int totalTrx,
  });

  @override
  $ShiftModelCopyWith<$Res> get shift;
}

/// @nodoc
class __$$ShiftSummaryModelImplCopyWithImpl<$Res>
    extends _$ShiftSummaryModelCopyWithImpl<$Res, _$ShiftSummaryModelImpl>
    implements _$$ShiftSummaryModelImplCopyWith<$Res> {
  __$$ShiftSummaryModelImplCopyWithImpl(
    _$ShiftSummaryModelImpl _value,
    $Res Function(_$ShiftSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shift = null,
    Object? totalSales = null,
    Object? totalTrx = null,
  }) {
    return _then(
      _$ShiftSummaryModelImpl(
        shift: null == shift
            ? _value.shift
            : shift // ignore: cast_nullable_to_non_nullable
                  as ShiftModel,
        totalSales: null == totalSales
            ? _value.totalSales
            : totalSales // ignore: cast_nullable_to_non_nullable
                  as double,
        totalTrx: null == totalTrx
            ? _value.totalTrx
            : totalTrx // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftSummaryModelImpl implements _ShiftSummaryModel {
  const _$ShiftSummaryModelImpl({
    required this.shift,
    @JsonKey(name: 'total_sales') required this.totalSales,
    @JsonKey(name: 'total_trx') required this.totalTrx,
  });

  factory _$ShiftSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftSummaryModelImplFromJson(json);

  @override
  final ShiftModel shift;
  @override
  @JsonKey(name: 'total_sales')
  final double totalSales;
  @override
  @JsonKey(name: 'total_trx')
  final int totalTrx;

  @override
  String toString() {
    return 'ShiftSummaryModel(shift: $shift, totalSales: $totalSales, totalTrx: $totalTrx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftSummaryModelImpl &&
            (identical(other.shift, shift) || other.shift == shift) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalTrx, totalTrx) ||
                other.totalTrx == totalTrx));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shift, totalSales, totalTrx);

  /// Create a copy of ShiftSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftSummaryModelImplCopyWith<_$ShiftSummaryModelImpl> get copyWith =>
      __$$ShiftSummaryModelImplCopyWithImpl<_$ShiftSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftSummaryModelImplToJson(this);
  }
}

abstract class _ShiftSummaryModel implements ShiftSummaryModel {
  const factory _ShiftSummaryModel({
    required final ShiftModel shift,
    @JsonKey(name: 'total_sales') required final double totalSales,
    @JsonKey(name: 'total_trx') required final int totalTrx,
  }) = _$ShiftSummaryModelImpl;

  factory _ShiftSummaryModel.fromJson(Map<String, dynamic> json) =
      _$ShiftSummaryModelImpl.fromJson;

  @override
  ShiftModel get shift;
  @override
  @JsonKey(name: 'total_sales')
  double get totalSales;
  @override
  @JsonKey(name: 'total_trx')
  int get totalTrx;

  /// Create a copy of ShiftSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftSummaryModelImplCopyWith<_$ShiftSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
