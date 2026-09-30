import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/app_database.dart';
import '../models/wirid_model.dart';
import '../repository/wirid_repository.dart';

final wiridRepositoryProvider = Provider<WiridRepository>((ref) {
  return WiridRepository(
    AppDatabase(),
  );
});

final wiridPagiProvider =
    FutureProvider<List<WiridModel>>((ref) async {
  final repository = ref.read(wiridRepositoryProvider);

  return repository.getWiridByCategory('pagi');
});

final wiridPetangProvider =
    FutureProvider<List<WiridModel>>((ref) async {
  final repository = ref.read(wiridRepositoryProvider);

  return repository.getWiridByCategory('petang');
});

final wiridSetelahSholatProvider =
    FutureProvider<List<WiridModel>>((ref) async {
  final repository = ref.read(wiridRepositoryProvider);

  return repository.getWiridByCategory('setelah_sholat');
});