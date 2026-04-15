class ConnectivityState {
  final bool isOnline;

  const ConnectivityState({required this.isOnline});

  ConnectivityState copyWith({bool? isOnline}) {
    return ConnectivityState(isOnline: isOnline ?? this.isOnline);
  }
}
