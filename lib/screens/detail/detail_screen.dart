import 'package:flutter/material.dart';
import 'package:tadabbur_app/core/theme/app_colors.dart';
import 'package:tadabbur_app/models/asma_model.dart';

class DetailScreen extends StatelessWidget {
  final AsmaModel item;

  const DetailScreen({
    super.key,
    required this.item,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardbackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.5),
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, //buat taro isi column di tengah dgn vertikal
                children: [
                  Text(
                    "${item.id}/99",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 30,),

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
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 20,
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 8),

            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardbackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.1),
                )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "arab",
                    style: TextStyle(
                     color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),

                  Text(
                   " -  ${item.arabic}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 8),

            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardbackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.1),
                )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "latin",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),

                  Text(
                    " -  ${item.latin}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            
            SizedBox(height: 8),

            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardbackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.1),
                )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "meaning",
                    style: TextStyle(
                     color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),

                  Text(
                    " -  ${item.meaning}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
