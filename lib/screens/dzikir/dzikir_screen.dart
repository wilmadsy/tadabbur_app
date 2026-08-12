import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tadabbur_app/core/theme/app_colors.dart';
import 'package:tadabbur_app/models/asma_model.dart';
import 'package:tadabbur_app/providers/dzikir_provider.dart';
import 'package:tadabbur_app/providers/sound_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tadabbur_app/providers/audio_player_provider.dart';
import 'package:tadabbur_app/providers/vibration_provider.dart';
import 'package:vibration/vibration.dart';
import '../../repository/dzikir_repository.dart';

class DzikirScreen extends ConsumerWidget {
  const DzikirScreen({super.key, required this.item});

  final AsmaModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countMap = ref.watch(dzikirProvider);
    final player = ref.read(AudioPlayerProvider);
    final count = countMap[item.id] ?? 0;
    final repository = DzikirRepository();
    final todayDzikir = repository.getTodayDzikir();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, //buat taro isi column di tengah dgn vertikal
              children: [
                SizedBox(height: 30),

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
                  style: TextStyle(color: AppColors.gold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "$count / 100",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    ref.read(vibrationProvider.notifier).toggle();
                  },
                  icon: Icon(
                    ref.watch(vibrationProvider)
                        ? Icons.vibration
                        : Icons.phone_android_outlined,
                    color: AppColors.gold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    ref.read(soundProvider.notifier).toggle();
                  },
                  icon: Icon(
                    ref.watch(soundProvider)
                        ? Icons.volume_up
                        : Icons.volume_off,
                    color: AppColors.gold,
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () async {
                ref.read(dzikirProvider.notifier).increment(item.id);
                

                if (ref.read(soundProvider)) {
                  await player.play(AssetSource("audio/click.mp3"));
                }

                final hasVibrator = await Vibration.hasVibrator();

                print(hasVibrator);

                // Getaran
                if (ref.read(vibrationProvider)) {
                  if (await Vibration.hasVibrator()) {
                    Vibration.vibrate(duration: 100);
                  }
                }
              },

              child: Image.asset(
                "assets/images/dzikir_circle.png",
                width: 280,
                height: 280,
              ),
            ),

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: AppColors.cardbackground,
                        borderRadius: BorderRadius.circular(18),
                        border: Border(
                          top: BorderSide(color: AppColors.gold, width: 1),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "beranda",
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "kembali ke home",
                              style: TextStyle(
                                color: AppColors.text.withOpacity(.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      ref.read(dzikirProvider.notifier).reset(item.id);
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: AppColors.cardbackground,
                        borderRadius: BorderRadius.circular(18),
                        border: Border(
                          top: BorderSide(color: AppColors.gold, width: 1),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reset",
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Ulangi hitungan",
                              style: TextStyle(
                                color: AppColors.text.withOpacity(.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
