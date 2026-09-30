import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tadabbur_app/screens/detail/detail_screen.dart';
import 'package:tadabbur_app/screens/home/widgets/asma_card.dart';
import '../../providers/theme_provider.dart';
import '../../providers/daily_asma_provider.dart';
import '../../providers/asma_notifier.dart';
import '../../core/theme/app_colors.dart';
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
    final today = ref.watch(dailyAsmaProvider);
    final asmaAsync = ref.watch(asmaNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: asmaAsync.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },

          error: (error, stack) {
            return Center(
              child: Text(
                'Gagal mengambil data Asma: $error',
                style: TextStyle(
                  color: AppColors.text,
                ),
              ),
            );
          },

          data: (asmaList) {
            final filteredList = asmaList.where((item) {
              return item.arabic.toLowerCase().contains(
                    search.toLowerCase(),
                  ) ||
                  item.latin.toLowerCase().contains(
                    search.toLowerCase(),
                  ) ||
                  item.meaning.toLowerCase().contains(
                    search.toLowerCase(),
                  );
            }).toList();

            return CustomScrollView(
              slivers: [

                // =========================
                // HEADER
                // =========================
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =========================
                        // TEKS HEADER
                        // =========================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Assalamu'alaikum",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Mulai hari ini dengan\nmengingat nama-nama Allah",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // =========================
                        // TOMBOL DARK / LIGHT
                        // =========================
                        IconButton(
                          onPressed: () {
                            ref.read(themeProvider.notifier).toggleTheme();
                          },
                          icon: Icon(
                            ref.watch(themeProvider)
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                            color: AppColors.gold,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // =========================
                // DAILY CARD
                // =========================
                SliverToBoxAdapter(
                  child: DailyCard(
                    today: today,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            item: today,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // =========================
                // PROGRESS CARD
                // =========================
                SliverToBoxAdapter(
                  child: GestureDetector(
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
                ),

                // =========================
                // SEARCH BAR
                // =========================
                SliverToBoxAdapter(
                  child: SearchBarWidget(
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                  ),
                ),

                // =========================
                // ASMA GRID
                // =========================
                SliverGrid.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0.1,
                    crossAxisSpacing: 0.1,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: AsmaCard(
                        item: filteredList[index],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}