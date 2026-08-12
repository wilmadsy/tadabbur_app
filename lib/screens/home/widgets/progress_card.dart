import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tadabbur_app/providers/streak_provider.dart';
import '../../../core/theme/app_colors.dart';
import 'progress_section.dart';
import 'stat_card.dart';
import '../../../providers/dzikir_provider.dart';

class ProgressCard extends ConsumerWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dzikirMap = ref.watch(dzikirProvider);
    final totalDzikir = dzikirMap.values.fold(0, (sum, item) => sum + item);

    final notifier = ref.read(dzikirProvider.notifier);
    final completed = notifier.getCompletedAsma();
    final progress = notifier.getProgress();
    final streak = ref.watch(streakProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.cardbackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(.25)),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// BAGIAN KIRI
          Expanded(
            flex: 5,
            child: ProgressSection(completed: completed, progress: progress),
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
                    value: "${totalDzikir}/100x",
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
  }
}
