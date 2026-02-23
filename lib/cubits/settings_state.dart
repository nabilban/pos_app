import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool diskon10,
    @Default(false) bool cashback50,
    @Default(false) bool gratisMinuman,
    @Default(true) bool cetakStruk,
    @Default(false) bool cetakKasir,
    @Default(true) bool cetakWaktu,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
