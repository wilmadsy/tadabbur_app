import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tadabbur_app/screens/dzikir/dzikir_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../../detail/detail_screen.dart';
import 'package:tadabbur_app/models/asma_model.dart';
// import '../../../providers/asma_notifier.dart';

class AsmaCard extends ConsumerWidget {
  final AsmaModel item;

  const AsmaCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            item: item,
                          ),
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
                            fontSize:
                                item.arabic == "ذُوالْجَلاَلِ وَالإكْرَام"
                                    ? 16
                                    : 28,
                            fontFamily: 'Amiri',
                          ),
                        ),

                        const SizedBox(height: 2),

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

                  // Positioned(
                  //   top: -8,
                  //   right: -8,
                  //   child: IconButton(
                  //     padding: EdgeInsets.zero,
                  //     constraints: const BoxConstraints(
                  //       minWidth: 28,
                  //       minHeight: 28,
                  //     ),
                  //     icon: Icon(
                  //       item.favorite
                  //           ? Icons.favorite
                  //           : Icons.favorite_border,
                  //       color: item.favorite
                  //           ? AppColors.gold
                  //           : AppColors.text.withOpacity(0.5),
                  //       size: 18,
                  //     ),
                  //     onPressed: () {
                  //       ref
                  //           .read(asmaNotifierProvider.notifier)
                  //           .updateFavorite(
                  //             item.id,
                  //             !item.favorite,
                  //           );
                  //     },
                  //   ),
                  // ),
                ],
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