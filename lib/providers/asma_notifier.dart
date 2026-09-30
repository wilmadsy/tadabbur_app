import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/asma_model.dart';
import '../repository/asma_repository.dart';
import '../core/database/app_database.dart';

class AsmaNotifier extends AsyncNotifier<List<AsmaModel>> {
  late final AsmaRepository _repository;

  @override
  Future<List<AsmaModel>> build() async {
    final database = AppDatabase();

    _repository = AsmaRepository(database);

    return _repository.getAllAsma();
  }

  Future<void> updateFavorite(int id, bool favorite) async {
    await _repository.updateFavorite(id, favorite);

    final currentList = state.value;

    if (currentList == null) {
      return;
    }

    state = AsyncData(
      currentList.map((item) {
        if (item.id == id) {
          return AsmaModel(
            id: item.id,
            arabic: item.arabic,
            latin: item.latin,
            meaning: item.meaning,
            count: item.count,
            progress: item.progress,
            favorite: favorite,
          );
        }

        return item;
      }).toList(),
    );
  }

  Future<void> updateCount(int id, int count) async {
    await _repository.updateCount(id, count);

    final currentList = state.value;

    if (currentList == null) {
      return;
    }

    state = AsyncData(
      currentList.map((item) {
        if (item.id == id) {
          return AsmaModel(
            id: item.id,
            arabic: item.arabic,
            latin: item.latin,
            meaning: item.meaning,
            count: count,
            progress: item.progress,
            favorite: item.favorite,
          );
        }

        return item;
      }).toList(),
    );
  }

  Future<void> updateProgress(int id, int progress) async {
    await _repository.updateProgress(id, progress);

    final currentList = state.value;

    if (currentList == null) {
      return;
    }

    state = AsyncData(
      currentList.map((item) {
        if (item.id == id) {
          return AsmaModel(
            id: item.id,
            arabic: item.arabic,
            latin: item.latin,
            meaning: item.meaning,
            count: item.count,
            progress: progress,
            favorite: item.favorite,
          );
        }

        return item;
      }).toList(),
    );
  }

}

final asmaNotifierProvider =
    AsyncNotifierProvider<AsmaNotifier, List<AsmaModel>>(
  AsmaNotifier.new,
);