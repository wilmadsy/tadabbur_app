import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/dzikir_provider.dart';
import '../../providers/streak_provider.dart';

class StepTadabbur extends ConsumerWidget {
  const StepTadabbur({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dzikirMap = ref.watch(dzikirProvider);

    // =========================
    // DATA PERJALANAN
    // =========================

    final totalDzikir = dzikirMap.values.fold(
      0,
      (sum, count) => sum + count,
    );

    final completedAsma = dzikirMap.values
        .where((count) => count > 0)
        .length;

    final progress = completedAsma / 99;

    final streak = ref.watch(streakProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.gold,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Perjalanan Tadabbur",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // =========================
            // HEADER
            // =========================

            const Text(
              "PERJALANAN TADABBUR",
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Teruskan langkahmu bersama Asmaul Husna.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // =========================
            // PROGRESS CARD
            // =========================

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardbackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.gold.withOpacity(.25),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Progress Asma",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),

                      Text(
                        "$completedAsma / 99",
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.white10,
                      valueColor:
                          const AlwaysStoppedAnimation(
                        AppColors.gold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${(progress * 100).toStringAsFixed(0)}% perjalanan",
                    style: TextStyle(
                      color: AppColors.text.withOpacity(.7),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // STAT
            // =========================

            Row(
              children: [

                Expanded(
                  child: _JourneyStatCard(
                    icon: Icons.auto_awesome,
                    title: "Total Dzikir",
                    value: "$totalDzikir",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _JourneyStatCard(
                    icon: Icons.local_fire_department,
                    title: "Streak",
                    value: "$streak Hari",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // =========================
            // TITLE
            // =========================

            const Text(
              "Jejak Asma",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Asma yang sudah kamu mulai tadabburi.",
              style: TextStyle(
                color: AppColors.text.withOpacity(.65),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // LIST ASMA YANG SUDAH DIMULAI
            // =========================

            ...dzikirMap.entries
                .where((entry) => entry.value > 0)
                .map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardbackground,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.gold.withOpacity(.15),
                      ),
                    ),

                    child: Row(
                      children: [

                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.gold
                                  .withOpacity(.4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${entry.key}",
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            "Asma ke-${entry.key}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "${entry.value}x",
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            if (completedAsma == 0)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardbackground,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.gold,
                      size: 32,
                    ),

                    SizedBox(height: 12),

                    Text(
                      "Belum ada perjalanan dimulai",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Mulai berdzikir pada salah satu Asmaul Husna.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}


// =====================================================
// STAT CARD
// =====================================================

class _JourneyStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _JourneyStatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardbackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withOpacity(.2),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: AppColors.gold,
            size: 22,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: TextStyle(
              color: AppColors.text.withOpacity(.65),
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}