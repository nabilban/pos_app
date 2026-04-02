import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleDiskon10(bool v) => emit(state.copyWith(diskon10: v));
  void toggleCashback50(bool v) => emit(state.copyWith(cashback50: v));
  void toggleGratisMinuman(bool v) => emit(state.copyWith(gratisMinuman: v));
  void toggleCetakStruk(bool v) => emit(state.copyWith(cetakStruk: v));
  void toggleCetakKasir(bool v) => emit(state.copyWith(cetakKasir: v));
  void toggleCetakWaktu(bool v) => emit(state.copyWith(cetakWaktu: v));
}
