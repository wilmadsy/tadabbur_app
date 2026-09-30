import '../core/database/app_database.dart';
import '../models/asma_model.dart';

class AsmaRepository {
  final AppDatabase database;

  AsmaRepository(this.database);

  Future<List<AsmaModel>> getAllAsma() async {
    return await database.getAllAsma();
  }

  Future<void> updateFavorite(int id, bool favorite) async {
    await database.updateFavorite(id, favorite);
  }

  Future<void> updateCount(int id, int count) async {
    await database.updateCount(id, count);
  }

  Future<void> updateProgress(int id, int progress) async {
    await database.updateProgress(id, progress);
  }
}