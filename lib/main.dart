import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_colors.dart';
import 'core/database/app_database.dart';
import 'repository/asma_repository.dart';
import 'screens/main/main_screen.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  print("MAIN DIMULAI");

  WidgetsFlutterBinding.ensureInitialized();

  // =========================
  // INIT SQLITE
  // =========================
  final database = AppDatabase();

  await database.initAsmaData();
  await database.initWiridData();

  // =========================
  // TEST REPOSITORY
  // =========================
  final repository = AsmaRepository(database);

  final asmaFromRepository = await repository.getAllAsma();

  print('Jumlah Asma dari Repository: ${asmaFromRepository.length}');

  // =========================
  // RUN APP
  // =========================
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLight = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
      ),

      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,

      home: const MainScreen(),
    );
  }
}
