import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/main/main_screen.dart';

Future<void> main() async {
  print("MAIN DIMULAI");

  WidgetsFlutterBinding.ensureInitialized();

  print("INIT HIVE");

  await Hive.initFlutter();

  print("OPEN BOX");

  await Hive.openBox("dzikirBox");
  await Hive.openBox("appBox");

  print("BOX DIBUKA");

  print(Hive.openBox("dzikirBox"));

  runApp(
    const ProviderScope(
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
