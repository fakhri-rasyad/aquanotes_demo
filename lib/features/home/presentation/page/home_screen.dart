import 'package:aquanotes/features/status/presentation/page/status_screen.dart';
import 'package:aquanotes/features/notifikasi/presentation/page/notifikasi_screen.dart';
import 'package:aquanotes/features/profile/presentation/page/profile_screen.dart';
import 'package:aquanotes/features/tagihan/presentation/page/tagihan_screen.dart';
import 'package:aquanotes/features/dashboard/presentation/page/dashboard_screen.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  final List<Widget> pages = [
    const DashboardScreen(),
    const NotifikasiScreen(),
    const TagihanScreen(),
    const ProfileScreen()
  ];

  void onTabPressed(int index) {
    setState(() {
      currentIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Ensure FAB overlays BottomNavigationBar smoothly
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0, // Space between FAB and BottomAppBar
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: onTabPressed,
          selectedItemColor: AppColors.gradientStart,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed, // Prevents shifting behavior
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Notifikasi"),
            BottomNavigationBarItem(
                icon: Icon(Icons.payments), label: "Tagihan"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gradientStart,
        foregroundColor: AppColors.secondary,
        shape: const CircleBorder(
          side: BorderSide(width: 4.0, color: AppColors.secondary),
        ),
        onPressed: () {
          Navigator.pushNamed(context, StatusScreen.routeName);
        },
        child: const Icon(Icons.insights_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
