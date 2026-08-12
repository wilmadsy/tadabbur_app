import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: AppColors.cardbackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.gold.withOpacity(.2),
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: AppColors.gold,
            size: 20,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}