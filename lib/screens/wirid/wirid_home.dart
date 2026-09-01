import 'package:flutter/material.dart';
import 'package:tadabbur_app/core/theme/app_colors.dart';
import 'package:tadabbur_app/models/wirid_model.dart';
import '../../data/wirid/wirid_pagi.dart';
import '../../data/wirid/wirid_petang.dart';
import '../../data/wirid/wirid_setelahsholat.dart';
import 'wirid_detail.dart';

class WiridHome extends StatelessWidget {
  const WiridHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "Wirid",
          style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _wiridCard(
            context,
            icon: Icons.wb_sunny_outlined,
            title: "Wirid Pagi",
            subtitle: "Dzikir dan doa untuk mengawali hari",
            wirid: wiridPagi,
          ),

          const SizedBox(height: 12),

          _wiridCard(
            context,
            icon: Icons.nightlight_outlined,
            title: "Wirid Petang",
            subtitle: "Dzikir dan doa untuk menutup hari",
            wirid: wiridpetang,
          ),

          const SizedBox(height: 12),

          _wiridCard(
            context,
            icon: Icons.mosque_outlined,
            title: "Wirid Setelah Shalat",
            subtitle: "Dzikir setelah menunaikan shalat",
            wirid: wiridSetelahSholat,
          ),
        ],
      ),
    );
  }

  Widget _wiridCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<WiridModel> wirid,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WiridDetail(
              title: title,
              wirid: wirid,
            ),
          ),
        );
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.cardbackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gold.withOpacity(.25)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold, size: 32),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.text.withOpacity(.65),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: AppColors.gold),
          ],
        ),
      ),
    );
  }
}
