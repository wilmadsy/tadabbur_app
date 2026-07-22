import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DzikirNotifier extends StateNotifier<Map<int, int>> {
  DzikirNotifier() : super({});

  void increment(int id) {
    state = {...state, id: (state[id] ?? 0) + 1};
  }


  void reset(int id) {
    state = {...state, id: 0};
  }
}

final dzikirProvider = StateNotifierProvider<DzikirNotifier, Map<int, int>>(
  (ref) => DzikirNotifier(),
);
