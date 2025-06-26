import 'package:aquanotes/features/divais/presentation/page/divais.dart';
import 'package:aquanotes/features/feedvision/presentation/page/feedvision_screen.dart';
import 'package:aquanotes/features/kolam/presentation/page/kolam.dart';
import 'package:aquanotes/features/monitoring/presentation/page/monitoring_screen.dart';
import 'package:aquanotes/features/prediksi/presentation/page/prediksi_screen.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  MenuItem({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
        iconPath: "assets/images/home/dashboard/menu/kolam.png",
        label: "Kolam",
        onTap: () {
          Navigator.of(context).pushNamed(KolamScreen.routeName);
        },
      ),
      MenuItem(
        iconPath: "assets/images/home/dashboard/menu/monitoring.png",
        label: "Monitoring",
        onTap: () {
          Navigator.of(context).pushNamed(MonitoringScreen.routeName);
        },
      ),
      MenuItem(
        iconPath: "assets/images/home/dashboard/menu/divais.png",
        label: "Divais",
        onTap: () {
          Navigator.of(context).pushNamed(DivaisScreen.routeName);
        },
      ),
      MenuItem(
          iconPath: "assets/images/home/dashboard/menu/prediksi.png",
          label: "Prediksi",
          onTap: () {
            Navigator.of(context).pushNamed(PrediksiScreen.routeName);
          }),
      MenuItem(
        iconPath: "assets/images/home/dashboard/menu/survey.png",
        label: "Survey",
        onTap: () => showNotYetImplementedDialog(context),
      ),
      MenuItem(
        iconPath: "assets/images/home/dashboard/menu/aquanotes.png",
        label: "Aquanotes",
        onTap: () {
          Navigator.of(context).pushNamed(FeedvisionScreen.routeName);
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 1.0, // Ensures a square layout for grid items
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return MenuItemWidget(menuItem: menuItems[index]);
        },
      ),
    );
  }

  Future<void> showNotYetImplementedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        icon: const Icon(Icons.construction, color: AppColors.gradientStart),
        title: const Text(
          "Fitur Belum Tersedia",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gradientStart,
          ),
        ),
        content: const Text(
          "Maaf, fitur ini masih dalam pengembangan. Silakan coba lagi nanti.",
          style: TextStyle(color: AppColors.gradientStart),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(color: AppColors.gradientStart),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;

  const MenuItemWidget({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: menuItem.onTap,
      child: Column(
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppColors.fadeLightBlue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(7),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      menuItem.iconPath,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            menuItem.label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
