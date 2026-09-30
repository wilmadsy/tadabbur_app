import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/streak_repository.dart';
import '../core/database/app_database.dart';

class StreakNotifier extends StateNotifier<int> {
  final StreakRepository repository;

  StreakNotifier(this.repository) : super(0) {
    _loadStreak();
  }

  Future<void> _loadStreak() async {
    state = await repository.getStreak();
  }

  Future<void> updateStreak() async {
    final now = DateTime.now();

    final today =
        "${now.year}-${now.month}-${now.day}";

    final lastDate = await repository.getLastDate();

    if (lastDate == null) {
      state = 1;

      await repository.saveStreak(1);
      await repository.saveLastDate(today);

      return;
    }

    final old = DateTime.parse(lastDate);

    final diff = now
        .difference(
          DateTime(
            old.year,
            old.month,
            old.day,
          ),
        )
        .inDays;

    if (diff == 0) {
      return;
    }

    if (diff == 1) {
      state++;

      await repository.saveStreak(state);
      await repository.saveLastDate(today);
    } else {
      state = 1;

      await repository.saveStreak(1);
      await repository.saveLastDate(today);
    }
  }
}

final streakProvider =
    StateNotifierProvider<StreakNotifier, int>(
  (ref) => StreakNotifier(
    StreakRepository(
      AppDatabase(),
    ),
  ),
);