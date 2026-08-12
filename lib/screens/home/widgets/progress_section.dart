import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';

class ProgressSection extends ConsumerWidget {
  final int completed;
  final double progress;

  const ProgressSection({
    super.key,
    required this.completed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "PERJALANAN TADABBUR",
          style: TextStyle(
            color: AppColors.gold,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 10),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$completed / 99 Asma",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Text(
              "${(progress * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
