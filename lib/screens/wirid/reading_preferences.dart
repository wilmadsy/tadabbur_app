import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ReadingPreferences extends StatefulWidget {
  final double arabicFontSize;
  final double latinFontSize;
  final bool showLatin;
  final bool showMeaning;

  const ReadingPreferences({
    super.key,
    required this.arabicFontSize,
    required this.latinFontSize,
    required this.showLatin,
    required this.showMeaning,
  });

  @override
  State<ReadingPreferences> createState() => _ReadingPreferencesState();
}

class _ReadingPreferencesState extends State<ReadingPreferences> {
  late double arabicSize;
  late double latinSize;

  late bool showLatin;
  late bool showMeaning;

  @override
  void initState() {
    super.initState();

    arabicSize = widget.arabicFontSize;
    latinSize = widget.latinFontSize;

    showLatin = widget.showLatin;
    showMeaning = widget.showMeaning;
  }

  void _save() {
    Navigator.pop(
      context,
      ReadingPreferenceResult(
        arabicFontSize: arabicSize,
        latinFontSize: latinSize,
        showLatin: showLatin,
        showMeaning: showMeaning,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: _save,
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.gold,
          ),
        ),
        title: const Text(
          'Preferensi Membaca',
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [

          // =====================================================
          // UKURAN TEKS ARAB
          // =====================================================

          _section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ukuran Teks Arab',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    const Text(
                      '−',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 32,
                      ),
                    ),

                    Expanded(
                      child: Slider(
                        min: 20,
                        max: 60,
                        value: arabicSize,
                        activeColor: AppColors.gold,
                        onChanged: (value) {
                          setState(() {
                            arabicSize = value;
                          });
                        },
                      ),
                    ),

                    const Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: arabicSize,
                      fontFamily: 'Amiri',
                      height: 1.8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 2),

          // =====================================================
          // UKURAN TEKS LATIN
          // =====================================================

          // _section(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Ukuran Teks Latin',
          //         style: TextStyle(
          //           color: AppColors.text,
          //           fontSize: 22,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),

          //       const SizedBox(height: 18),

          //       Row(
          //         children: [
          //           const Text(
          //             '−',
          //             style: TextStyle(
          //               color: Colors.white70,
          //               fontSize: 32,
          //             ),
          //           ),

          //           Expanded(
          //             child: Slider(
          //               min: 12,
          //               max: 32,
          //               value: latinSize,
          //               activeColor: AppColors.gold,
          //               onChanged: (value) {
          //                 setState(() {
          //                   latinSize = value;
          //                 });
          //               },
          //             ),
          //           ),

          //           const Text(
          //             '+',
          //             style: TextStyle(
          //               color: Colors.white70,
          //               fontSize: 32,
          //             ),
          //           ),
          //         ],
          //       ),

          //       const SizedBox(height: 12),

          //       Center(
          //         child: Text(
          //           'Bismillahirrahmanirrahim',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: AppColors.text,
          //             fontSize: latinSize,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // const SizedBox(height: 12),

          // =====================================================
          // AKTIFKAN TEKS
          // =====================================================

          // _section(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Aktifkan Teks',
          //         style: TextStyle(
          //           color: AppColors.text,
          //           fontSize: 22,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),

          //       const SizedBox(height: 10),

          //       SwitchListTile(
          //         contentPadding: EdgeInsets.zero,
          //         title: const Text(
          //           'Transliterasi (Latin)',
          //           style: TextStyle(
          //             color: AppColors.text,
          //             fontSize: 17,
          //           ),
          //         ),
          //         value: showLatin,
          //         activeColor: AppColors.gold,
          //         onChanged: (value) {
          //           setState(() {
          //             showLatin = value;
          //           });
          //         },
          //       ),

          //       SwitchListTile(
          //         contentPadding: EdgeInsets.zero,
          //         title: const Text(
          //           'Terjemah',
          //           style: TextStyle(
          //             color: AppColors.text,
          //             fontSize: 17,
          //           ),
          //         ),
          //         value: showMeaning,
          //         activeColor: AppColors.gold,
          //         onChanged: (value) {
          //           setState(() {
          //             showMeaning = value;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _section({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        24,
        18,
        24,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardbackground,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gold.withOpacity(.12),
          ),
        ),
      ),
      child: child,
    );
  }
}


// =====================================================
// HASIL PENGATURAN
// =====================================================

class ReadingPreferenceResult {
  final double arabicFontSize;
  final double latinFontSize;
  final bool showLatin;
  final bool showMeaning;

  const ReadingPreferenceResult({
    required this.arabicFontSize,
    required this.latinFontSize,
    required this.showLatin,
    required this.showMeaning,
  });
}