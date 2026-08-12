import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/asma_model.dart';

class DailyCard extends StatelessWidget {
  final AsmaModel today;
  final VoidCallback? onTap;

  const DailyCard({
    super.key,
    required this.today,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 240,
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              /// Background
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.gold.withOpacity(.45),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    "assets/images/daily_background.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Isi
              Padding(
                padding: const EdgeInsets.only(
                  left: 26,
                  top: 58,
                  right: 150,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      today.arabic,
                      style: const TextStyle(
                        fontFamily: "Amiri",
                        fontSize: 56,
                        color: AppColors.gold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      today.latin,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      today.meaning,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              /// Label
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "ASMA HARI INI",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}