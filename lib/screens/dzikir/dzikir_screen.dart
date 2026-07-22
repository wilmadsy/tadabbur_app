import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tadabbur_app/core/theme/app_colors.dart';
import 'package:tadabbur_app/models/asma_model.dart';
import 'package:tadabbur_app/providers/dzikir_provider.dart';

class DzikirScreen extends ConsumerWidget {
  const DzikirScreen({super.key, required this.item});

  final AsmaModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countMap = ref.watch(dzikirProvider);
    final count = countMap[item.id] ?? 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, //buat taro isi column di tengah dgn vertikal
              children: [
                SizedBox(height: 30),

                Text(
                  item.arabic,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 54,
                    fontFamily: 'Amiri',
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  item.latin,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  item.meaning,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.gold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "$count / 100",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            Text(
              "target: 100",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            GestureDetector(
              onTap: () {
                ref.read(dzikirProvider.notifier).increment(item.id);
              },

              child: Image.asset(
                "assets/images/dzikir_circle.png",
                width: 280,
                height: 280,
              ),
            ),

            SizedBox(height: 15),

            GestureDetector(
              onTap: () {
                ref.read(dzikirProvider.notifier).reset(item.id);
              },

              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF102548),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFD4AF37),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      ref.read(dzikirProvider.notifier).reset(item.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restart_alt_rounded,
                            color: AppColors.gold,
                            size: 34,
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reset",
                                  style: TextStyle(
                                    color: AppColors.text,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  "Ulangi hitungan",
                                  style: TextStyle(
                                    color: AppColors.text.withOpacity(.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
