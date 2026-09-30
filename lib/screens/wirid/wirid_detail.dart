import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/wirid_model.dart';
import 'reading_preferences.dart';

class WiridDetail extends StatefulWidget {
  final String title;
  final List<WiridModel> wirid;

  const WiridDetail({
    super.key,
    required this.title,
    required this.wirid,
  });

  @override
  State<WiridDetail> createState() => _WiridDetailState();
}

class _WiridDetailState extends State<WiridDetail> {

  int currentPage = 0;

  // =====================================================
  // PREFERENSI MEMBACA
  // =====================================================

  double arabicFontSize = 24;
  double latinFontSize = 18;

  bool showLatin = true;
  bool showMeaning = true;

  // =====================================================
  // BUKA PREFERENSI
  // =====================================================

  Future<void> _openReadingPreferences() async {

    final result = await Navigator.push<ReadingPreferenceResult>(
      context,
      MaterialPageRoute(
        builder: (context) => ReadingPreferences(
          arabicFontSize: arabicFontSize,
          latinFontSize: latinFontSize,
          showLatin: showLatin,
          showMeaning: showMeaning,
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      arabicFontSize = result.arabicFontSize;
      latinFontSize = result.latinFontSize;
      showLatin = result.showLatin;
      showMeaning = result.showMeaning;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.gold,
          ),
        ),

        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          // =================================================
          // TOMBOL aA
          // =================================================

          IconButton(
            tooltip: 'Preferensi membaca',
            onPressed: _openReadingPreferences,
            icon: const Text(
              'aA',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 6),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: Column(
        children: [

          Expanded(
            child: PageView.builder(
              itemCount: widget.wirid.length,

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              itemBuilder: (context, index) {

                final item = widget.wirid[index];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    children: [

                      // =================================================
                      // JUDUL
                      // =================================================

                      Center(
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =================================================
                      // ARABIC
                      // =================================================

                      Text(
                        item.arabic,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: arabicFontSize,
                          height: 2,
                          fontFamily: 'Amiri',
                        ),
                      ),

                      // =================================================
                      // LATIN
                      // =================================================

                      if (showLatin &&
                          item.latin.trim().isNotEmpty) ...[
                        const SizedBox(height: 24),

                        Text(
                          item.latin,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: latinFontSize,
                            height: 1.6,
                          ),
                        ),
                      ],

                      // =================================================
                      // TERJEMAH
                      // =================================================

                      if (showMeaning &&
                          item.meaning.trim().isNotEmpty) ...[
                        const SizedBox(height: 18),

                        Text(
                          item.meaning,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.text.withOpacity(.75),
                            fontSize: 17,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          // =====================================================
          // PAGE INDICATOR
          // =====================================================

          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),

            child: Text(
              '${currentPage + 1} / ${widget.wirid.length}',
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}