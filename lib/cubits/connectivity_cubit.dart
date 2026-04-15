import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit(this._connectivity)
    : super(const ConnectivityState(isOnline: true)) {
    _init();
  }

  Future<void> _init() async {
    final current = await _connectivity.checkConnectivity();
    emit(state.copyWith(isOnline: _hasConnection(current)));

    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      emit(state.copyWith(isOnline: _hasConnection(results)));
    });
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
