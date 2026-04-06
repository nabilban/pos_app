import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/shift_repository.dart';
import 'shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  final IShiftRepository _repository;

  ShiftCubit(this._repository) : super(const ShiftState());

  Future<void> checkStatus(int userId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final shift = await _repository.getActiveShift(userId);
      emit(state.copyWith(isLoading: false, activeShift: shift));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> openShift(int userId, double initialCash, String? notes) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.openShift(userId, initialCash, notes);
      final shift = await _repository.getActiveShift(userId);
      emit(state.copyWith(isLoading: false, activeShift: shift));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> closeShift(int id, int userId, double finalCash, String? notes) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.closeShift(id, finalCash, notes);
      final shift = await _repository.getActiveShift(userId);
      emit(state.copyWith(isLoading: false, activeShift: shift));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
