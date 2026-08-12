import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardbackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.gold.withOpacity(.25),
          ),
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color: AppColors.text,
              ),
            ),

            Expanded(
              child: TextField(
                onChanged: onChanged,

                cursorColor: AppColors.gold,
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 16,
                ),

                decoration: InputDecoration(
                  hintText: "Cari Asma atau Arti...",
                  hintStyle: TextStyle(
                    color: AppColors.text.withOpacity(.55),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              width: 1,
              height: 28,
              color: AppColors.gold.withOpacity(.3),
            ),

            IconButton(
              splashRadius: 22,
              onPressed: () {},
              icon: Icon(
                Icons.tune_rounded,
                color: AppColors.gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}