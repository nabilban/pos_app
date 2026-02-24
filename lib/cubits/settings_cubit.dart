import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/pos_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final PosRepository _repository;

  SettingsCubit(this._repository) : super(const SettingsState()) {
    loadStoreInfo();
  }

  Future<void> loadStoreInfo() async {
    try {
      final storeInfo = await _repository.getStoreInfo();
      emit(state.copyWith(storeInfo: storeInfo));
    } catch (e) {
      // Handle error
    }
  }

  void toggleDiskon10(bool v) => emit(state.copyWith(diskon10: v));
  void toggleCashback50(bool v) => emit(state.copyWith(cashback50: v));
  void toggleGratisMinuman(bool v) => emit(state.copyWith(gratisMinuman: v));
  void toggleCetakStruk(bool v) => emit(state.copyWith(cetakStruk: v));
  void toggleCetakKasir(bool v) => emit(state.copyWith(cetakKasir: v));
  void toggleCetakWaktu(bool v) => emit(state.copyWith(cetakWaktu: v));
}
