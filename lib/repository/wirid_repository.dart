import '../core/database/app_database.dart';
import '../models/wirid_model.dart';

class WiridRepository {
  final AppDatabase database;

  WiridRepository(this.database);

  Future<List<WiridModel>> getAllWirid() async {
    final db = await database.database;

    final result = await db.query(
      'wirid',
      orderBy: 'id ASC',
    );

    return result.map((map) {
      return WiridModel.fromMap(map);
    }).toList();
  }

  Future<List<WiridModel>> getWiridByCategory(
    String category,
  ) async {
    final db = await database.database;

    final result = await db.query(
      'wirid',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'id ASC',
    );

    return result.map((map) {
      return WiridModel.fromMap(map);
    }).toList();
  }
}