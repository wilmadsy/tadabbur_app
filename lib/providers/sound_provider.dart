import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoundNotifier extends StateNotifier<bool> {
  SoundNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}

final soundProvider =
  StateNotifierProvider<SoundNotifier, bool>(
    (ref) => SoundNotifier(),
);

