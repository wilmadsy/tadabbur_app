import 'package:hive_flutter/hive_flutter.dart';

class StreakRepository {
  final Box _box = Hive.box("appBox");

  int getStreak() {
    return _box.get("streak", defaultValue: 0);
  }

  String? getLastDate() {
    return _box.get("lastDate");
  }

  Future<void> saveStreak(int streak) async {
    await _box.put("streak", streak);
  }

  Future<void> saveLastDate(String date) async {
    await _box.put("lastDate", date);
  }
}