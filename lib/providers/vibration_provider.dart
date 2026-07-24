import 'package:flutter_riverpod/flutter_riverpod.dart';

class VibrationNotifier extends StateNotifier<bool> {
  VibrationNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}


  final vibrationProvider =
    StateNotifierProvider<VibrationNotifier, bool>(
      (ref) => VibrationNotifier(),
    );