import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef CounterProvider = NotifierProvider<CounterNotifier, UiState>;

class CounterNotifier extends Notifier<UiState> {
  @override
  UiState build() => UiState(0, "");
  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void decrement() {
    state = state.copyWith(count: state.count - 1);
  }

  void updateInfo(String info) {
    state = state.copyWith(info: info);
  }
}

class UiState {
  final int count;
  final String info;
  UiState(this.count, this.info);
  UiState copyWith({int? count, String? info}) {
    return UiState(count ?? this.count, info ?? this.info);
  }
}
