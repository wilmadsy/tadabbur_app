import 'package:hive_flutter/hive_flutter.dart';

class DzikirRepository {
  final Box _box = Hive.box("dzikirBox");

  // =========================
  // DZIKIR PER ASMA
  // =========================

  int getCount(int id) {
    return _box.get(id, defaultValue: 0) ?? 0;
  }

  Future<void> saveCount(int id, int count) async {
    await _box.put(id, count);
  }

  int getTotalDzikir() {
    int total = 0;

    for (int id = 1; id <= 99; id++) {
      total += getCount(id);
    }

    return total;
  }

  Future<void> reset(int id) async {
    await _box.put(id, 0);
  }

  // =========================
  // DZIKIR HARI INI
  // =========================

  int getTodayDzikir() {
    return _box.get("todayDzikir", defaultValue: 0) ?? 0;
  }

  Future<void> saveTodayDzikir(int count) async {
    await _box.put("todayDzikir", count);
  }

  String? getLastDzikirDate() {
    return _box.get("lastDzikirDate");
  }

  Future<void> saveLastDzikirDate(String date) async {
    await _box.put("lastDzikirDate", date);
  }
}