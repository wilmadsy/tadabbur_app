import 'package:sqflite/sqflite.dart';
import '../../models/asma_model.dart';
import '../../data/asma_data.dart';
import 'package:path/path.dart';
import '../../data/wirid/wirid_pagi.dart';
import '../../data/wirid/wirid_petang.dart';
import '../../data/wirid/wirid_setelahsholat.dart';
class AppDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tadabbur.db');

    _database = await openDatabase(
      path,
      version: 3,

      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE asma (
            id INTEGER PRIMARY KEY,
            arabic TEXT NOT NULL,
            latin TEXT NOT NULL,
            meaning TEXT NOT NULL,
            count INTEGER NOT NULL,
            progress INTEGER NOT NULL,
            favorite INTEGER NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE app_data (
            key TEXT PRIMARY KEY,
            value TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE wirid (
            id INTEGER PRIMARY KEY,
            category TEXT NOT NULL,
            title TEXT NOT NULL,
            arabic TEXT NOT NULL,
            latin TEXT NOT NULL,
            meaning TEXT NOT NULL
          )
        ''');

      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE app_data (
              key TEXT PRIMARY KEY,
              value TEXT
            )
          ''');
        }

        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE wirid (
              id INTEGER PRIMARY KEY,
              category TEXT NOT NULL,
              title TEXT NOT NULL,
              arabic TEXT NOT NULL,
              latin TEXT NOT NULL,
              meaning TEXT NOT NULL
            )
          ''');
        }
      },
    );
    return _database!;
  }

  Future<void> insertAsmaData() async {
    final db = await database;

    for (final asma in asmaList) {
      await db.insert('asma', {
        'id': asma.id,
        'arabic': asma.arabic,
        'latin': asma.latin,
        'meaning': asma.meaning,
        'count': 0,
        'progress': 0,
        'favorite': 0,
      });
    }
  }

  Future<int> getAsmaCount() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM asma',
    );

    return result.first['total'] as int;
  }

  Future<void> initAsmaData() async {
    final count = await getAsmaCount();

    print('Jumlah Asma sebelum init: $count');

    if (count == 0) {
      await insertAsmaData();

      final newCount = await getAsmaCount();

      print('Jumlah Asma setelah insert: $newCount');
    }
  }

  Future<List<AsmaModel>> getAllAsma() async {
    final db = await database;

    final result = await db.query('asma');

    return result.map((map) {
      return AsmaModel.fromMap(map);
    }).toList();
  }

  Future<void> updateFavorite(int id, bool favorite) async {
    final db = await database;

    await db.update(
      'asma',
      {
        'favorite': favorite ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateCount(int id, int count) async {
    final db = await database;

    await db.update(
      'asma',
      {
        'count': count,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateProgress(int id, int progress) async {
    final db = await database;

    await db.update(
      'asma',
      {
        'progress': progress,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> initWiridData() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM wirid',
    );

    final count = result.first['total'] as int;

    if (count > 0) {
      return;
    }

    final batch = db.batch();

    for (final item in wiridPagi) {
      batch.insert('wirid', {
        'category': 'pagi',
        'title': item.title,
        'arabic': item.arabic,
        'latin': item.latin,
        'meaning': item.meaning,
      });
    }

    for (final item in wiridpetang) {
      batch.insert('wirid', {
        'category': 'petang',
        'title': item.title,
        'arabic': item.arabic,
        'latin': item.latin,
        'meaning': item.meaning,
      });
    }

    for (final item in wiridSetelahSholat) {
      batch.insert('wirid', {
        'category': 'setelah_sholat',
        'title': item.title,
        'arabic': item.arabic,
        'latin': item.latin,
        'meaning': item.meaning,
      });
    }

    await batch.commit();
  }

}
