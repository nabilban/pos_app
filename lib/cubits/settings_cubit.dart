import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/user_repository.dart';
import '../data/models/store_info.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final IUserRepository _userRepository;

  SettingsCubit(this._userRepository) : super(const SettingsState()) {
    loadStoreInfo();
  }

  Future<void> loadStoreInfo() async {
    try {
      final user = await _userRepository.getCurrentUser();
      if (user != null) {
        final storeInfo = StoreInfo(
          name: user.outlet?.name ?? 'FIESTO POS',
          address: user.outlet?.address ?? '',
          phone: user.outlet?.phone ?? '',
          cashierName: user.name,
        );
        emit(state.copyWith(storeInfo: storeInfo));
      }
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
