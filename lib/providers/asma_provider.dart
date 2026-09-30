import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/app_database.dart';
import '../models/asma_model.dart';
import '../repository/asma_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final asmaRepositoryProvider = Provider<AsmaRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return AsmaRepository(database);
});

final asmaProvider = FutureProvider<List<AsmaModel>>((ref) async {
  final repository = ref.watch(asmaRepositoryProvider);

  return repository.getAllAsma();
});