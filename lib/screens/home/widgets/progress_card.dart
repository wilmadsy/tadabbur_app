import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/dzikir_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/asma_notifier.dart';
import '../../../providers/streak_provider.dart';
import 'progress_section.dart';
import 'stat_card.dart';

class ProgressCard extends ConsumerWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asmaAsync = ref.watch(asmaNotifierProvider);
    final streak = ref.watch(streakProvider);
    final todayDzikirAsync = ref.watch(todayDzikirProvider);

    return asmaAsync.when(
      loading: () {
        return const SizedBox(
          height: 120,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },

      error: (error, stack) {
        return Center(
          child: Text(
            'Gagal mengambil progress: $error',
            style: TextStyle(
              color: AppColors.text,
            ),
          ),
        );
      },

      data: (asmaList) {
        // Berapa Asma yang sudah pernah didzikir
        final completed = asmaList.where(
          (item) => item.count > 0,
        ).length;

        // Progress 0.0 - 1.0
        final progress = completed / 99;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: AppColors.cardbackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.gold.withOpacity(.25),
            ),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// BAGIAN KIRI
              Expanded(
                flex: 5,
                child: ProgressSection(
                  completed: completed,
                  progress: progress,
                ),
              ),

              const SizedBox(width: 12),

              /// BAGIAN KANAN
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.auto_awesome,
                        title: "Dzikir Harian",
                        value: todayDzikirAsync.when(
                          loading: () => "...",
                          error: (_, __) => "0x",
                          data: (value) => "${value}/100x",
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: StatCard(
                        icon: Icons.local_fire_department,
                        title: "Streak",
                        value: "$streak hari",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}