import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/shift_repository.dart';
import 'shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  final IShiftRepository _repository;

  ShiftCubit(this._repository) : super(const ShiftState());

  Future<void> checkStatus(int userId) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final shift = await _repository.getActiveShift(userId);
      final history = await _repository.getHistory();
      emit(state.copyWith(
        isLoading: false,
        activeShift: shift,
        history: history,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadHistory() async {
    try {
      final history = await _repository.getHistory();
      emit(state.copyWith(history: history));
    } catch (e) {
      // Keep existing history on error
    }
  }

  void setTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  Future<void> openShift(int userId, double initialCash, String? notes) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.openShift(userId, initialCash, notes);
      final shift = await _repository.getActiveShift(userId);
      emit(state.copyWith(isLoading: false, activeShift: shift));
      loadHistory(); // Refresh history
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
      loadHistory(); // Refresh history
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateNotes(int id, String notes) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.updateShiftNotes(id, notes);
      await loadHistory();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> loadShiftSummary(int id) async {
    emit(state.copyWith(isSummaryLoading: true, selectedSummary: null));
    try {
      final summary = await _repository.getShiftSummary(id);
      emit(state.copyWith(isSummaryLoading: false, selectedSummary: summary));
    } catch (e) {
      emit(state.copyWith(isSummaryLoading: false, error: e.toString()));
    }
  }

  void clearSummary() {
    emit(state.copyWith(selectedSummary: null));
  }
}
