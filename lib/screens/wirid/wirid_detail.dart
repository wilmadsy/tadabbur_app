import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/wirid_model.dart';

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
  // Menyimpan halaman yang sedang aktif.
  // Flutter menggunakan index mulai dari 0:
  // 0 = halaman pertama
  // 1 = halaman kedua
  // 2 = halaman ketiga
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,

        // Membuat title AppBar berada di tengah.
        centerTitle: true,

        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: AppColors.gold,
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: Column(
        children: [
          // Expanded membuat PageView mengambil
          // ruang yang tersedia di antara AppBar
          // dan indikator halaman.
          Expanded(
            child: PageView.builder(
              // Jumlah halaman mengikuti jumlah
              // data WiridModel yang dikirim.
              itemCount: widget.wirid.length,

              // Dipanggil setiap kali user berpindah halaman.
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              // Membuat isi setiap halaman.
              itemBuilder: (context, index) {
                // Mengambil data berdasarkan index.
                final item = widget.wirid[index];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    children: [
                      // =========================
                      // JUDUL BACAAN
                      // =========================
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

                      // =========================
                      // TEKS ARAB
                      // =========================
                      Text(
                        item.arabic,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // =========================
          // INDIKATOR HALAMAN
          // =========================
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