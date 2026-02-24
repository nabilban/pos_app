import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/store_info.dart';

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
    @Default(
      StoreInfo(
        name: 'FIESTO POS',
        address: 'Jl. Sudirman No. 123, Surabaya',
        phone: '0812-3456-7890',
        cashierName: 'Ahmad',
      ),
    )
    StoreInfo storeInfo,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
