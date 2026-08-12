import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tadabbur_app/screens/detail/detail_screen.dart';
import 'package:tadabbur_app/screens/home/widgets/asma_card.dart';
import '../../providers/daily_asma_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../data/asma_data.dart';
import 'widgets/progress_card.dart';
import 'widgets/daily_card.dart';
import 'widgets/search_bar.dart';
import '../step/step_tadabbur.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onTap;
    final today = ref.watch(dailyAsmaProvider);
    final filteredList = asmaList.where((item) {
      return item.arabic.toLowerCase().contains(search.toLowerCase()) ||
          item.latin.toLowerCase().contains(search.toLowerCase()) ||
          item.meaning.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assalamu'alaikum",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: AppColors.gold, fontSize: 15),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Mulai hari ini dengan\nmengingat nama-nama Allah ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: AppColors.text, fontSize: 12),
                  ),
                ],
              ),
            ),

            // dailycard
            DailyCard(
              today: today,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      item: today
                    ),
                  ),
                );
              },
            ),

            // progresscard
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StepTadabbur(),
                  ),
                );
              },
              child: const ProgressCard(),
            ),

            // search bar
            SearchBarWidget(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),

            //asma card
            Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0.1,
                  crossAxisSpacing: 0.1,
                ),

                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return AsmaCard(item: filteredList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
