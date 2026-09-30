import 'package:sqflite/sqflite.dart';

import '../core/database/app_database.dart';

class StreakRepository {
  final AppDatabase database;

  StreakRepository(this.database);

  Future<int> getStreak() async {
    final db = await database.database;

    final result = await db.query(
      'app_data',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['streak'],
    );

    if (result.isEmpty) {
      return 0;
    }

    return int.tryParse(
          result.first['value'] as String? ?? '0',
        ) ??
        0;
  }

  Future<String?> getLastDate() async {
    final db = await database.database;

    final result = await db.query(
      'app_data',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['lastDate'],
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first['value'] as String?;
  }

  Future<void> saveStreak(int streak) async {
    final db = await database.database;

    await db.insert(
      'app_data',
      {
        'key': 'streak',
        'value': streak.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> saveLastDate(String date) async {
    final db = await database.database;

    await db.insert(
      'app_data',
      {
        'key': 'lastDate',
        'value': date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}