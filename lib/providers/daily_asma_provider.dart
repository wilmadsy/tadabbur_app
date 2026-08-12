import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/asma_data.dart';
import '../models/asma_model.dart';

final dailyAsmaProvider = Provider<AsmaModel>((ref) {
  final now = DateTime.now();

  // tiap hari berubah
  final index = now.difference(DateTime(2026, 1, 1)).inDays % asmaList.length;

  return asmaList[index];
});
