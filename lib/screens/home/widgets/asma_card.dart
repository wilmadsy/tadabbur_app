import 'package:flutter/material.dart';
import 'package:tadabbur_app/screens/dzikir/dzikir_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/asma_data.dart';
import '../../detail/detail_screen.dart';
import 'package:tadabbur_app/models/asma_model.dart';

class AsmaCard extends StatelessWidget {
  final AsmaModel item;

  const AsmaCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.cardbackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.6),
            width: 0.4,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(item: item),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.arabic,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: item.arabic == "ذُوالْجَلاَلِ وَالإكْرَام"
                            ? 16
                            : 28,
                        fontFamily: 'Amiri',
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      item.latin,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => DzikirScreen(
                        item: item,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.gold.withOpacity(0.5),
                        width: 0.5,
                      ),
                    ),
                  ),

                  child: Center(
                    child: Text(
                      "📿 Dzikir",
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
