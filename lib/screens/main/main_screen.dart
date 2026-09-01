import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../home/home_screen.dart';
import '../wirid/wirid_home.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final PageController pageController = PageController();

  final List<Widget> pages = const [
    HomePage(),
    WiridHome(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: PageView(
        controller: pageController,

        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        children: pages,
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardbackground,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.gold.withOpacity(.25),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });

            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },

          backgroundColor: Colors.transparent,
          elevation: 0,

          selectedItemColor: AppColors.gold,
          unselectedItemColor: AppColors.text.withOpacity(.5),

          selectedFontSize: 11,
          unselectedFontSize: 11,

          type: BottomNavigationBarType.fixed,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Asma",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book),
              label: "Wirid",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}