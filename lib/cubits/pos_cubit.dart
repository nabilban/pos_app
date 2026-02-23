import 'package:flutter_bloc/flutter_bloc.dart';
import 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(const PosState());

  void setCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
