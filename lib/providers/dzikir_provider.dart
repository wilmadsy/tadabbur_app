import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/dzikir_repository.dart';
import 'streak_provider.dart';

class DzikirNotifier extends StateNotifier<Map<int, int>> {
  final DzikirRepository repository;
  final Ref ref;

  DzikirNotifier(this.repository, this.ref) : super({}) {
    _loadData();
  }

  /// Ambil semua data dari Hive saat aplikasi dibuka
  void _loadData() {
    final data = <int, int>{};

    for (int i = 1; i <= 99; i++) {
      data[i] = repository.getCount(i);
    }

    state = data;
  }

  /// Tambah dzikir
  Future<void> increment(int id) async {
    final newCount = (state[id] ?? 0) + 1;

    print("SAVE -> $id : $newCount");

    await repository.saveCount(id, newCount);

    state = {...state, id: newCount};

    // DZIKIR HARI INI
    final today = DateTime.now();
    final todayString = "${today.year}-${today.month}-${today.day}";

    final lastDate = repository.getLastDzikirDate();

    int todayDzikir = repository.getTodayDzikir();

    // Kalau sudah berganti hari → reset hitungan hari ini
    if (lastDate != todayString) {
      todayDzikir = 0;
    }

    todayDzikir++;

    await repository.saveTodayDzikir(todayDzikir);
    await repository.saveLastDzikirDate(todayString);

    print("DZIKIR HARI INI = $todayDzikir");

    // CEK STREAK
    if (todayDzikir == 100) {
      await ref.read(streakProvider.notifier).updateStreak();
    }
  }

  /// Reset dzikir
  Future<void> reset(int id) async {
    await repository.reset(id);

    state = {...state, id: 0};
  }

  /// Total seluruh dzikir
  int getTotalDzikir() {
    return state.values.fold(0, (sum, value) => sum + value);
  }

  int getTodayDzikir() {
    return repository.getTodayDzikir();
  }

  /// Berapa Asma yang sudah pernah didzikir (count > 0)
  int getCompletedAsma() {
    return state.values.where((count) => count > 0).length;
  }

  /// Progress 0.0 - 1.0
  double getProgress() {
    return getCompletedAsma() / 99;
  }
}

final dzikirProvider = StateNotifierProvider<DzikirNotifier, Map<int, int>>(
  (ref) => DzikirNotifier(
    DzikirRepository(),
    ref,),
);
