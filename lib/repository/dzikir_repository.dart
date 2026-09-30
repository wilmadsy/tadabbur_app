import 'package:sqflite/sqflite.dart';
import '../core/database/app_database.dart';

class DzikirRepository {
  final AppDatabase database;

  DzikirRepository(this.database);

  // =========================
  // DZIKIR PER ASMA
  // =========================

  Future<int> getCount(int id) async {
    final db = await database.database;

    final result = await db.query(
      'asma',
      columns: ['count'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return 0;
    }

    return result.first['count'] as int;
  }

  Future<void> saveCount(int id, int count) async {
    await database.updateCount(id, count);
  }

  Future<int> getTotalDzikir() async {
    final db = await database.database;

    final result = await db.rawQuery(
      'SELECT SUM(count) as total FROM asma',
    );

    return (result.first['total'] as int?) ?? 0;
  }

  Future<void> reset(int id) async {
    await database.updateCount(id, 0);
  }

  // =========================
  // DZIKIR HARI INI
  // =========================

  Future<int> getTodayDzikir() async {
    final db = await database.database;

    final result = await db.query(
      'app_data',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['todayDzikir'],
    );

    if (result.isEmpty) {
      return 0;
    }

    return int.tryParse(
          result.first['value'] as String? ?? '0',
        ) ??
        0;
  }

  Future<void> saveTodayDzikir(int count) async {
    final db = await database.database;

    await db.insert(
      'app_data',
      {
        'key': 'todayDzikir',
        'value': count.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getLastDzikirDate() async {
    final db = await database.database;

    final result = await db.query(
      'app_data',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['lastDzikirDate'],
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first['value'] as String?;
  }

  Future<void> saveLastDzikirDate(String date) async {
    final db = await database.database;

    await db.insert(
      'app_data',
      {
        'key': 'lastDzikirDate',
        'value': date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}