import 'package:freezed_annotation/freezed_annotation.dart';

part 'pos_state.freezed.dart';

@freezed
class PosState with _$PosState {
  const factory PosState({@Default('Semua') String selectedCategory}) =
      _PosState;
}
