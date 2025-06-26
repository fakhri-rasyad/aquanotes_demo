import 'package:aquanotes/features/prediksi/presentation/page/about_screen.dart';
import 'package:aquanotes/features/amonia/presentation/page/amonia_screen.dart';
import 'package:aquanotes/features/performa/presentation/page/performa_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:aquanotes/theme/colors.dart';

class PrediksiScreen extends StatelessWidget {
  const PrediksiScreen({super.key});
  static const routeName = "/prediksi";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<PrediksiOptionItem> options = [
      const PrediksiOptionItem(
          title: "Kadar Amonia",
          subtitle: "Untuk mengetahui tingkat racun pada kolam",
          icon: Icons.thermostat_auto),
      const PrediksiOptionItem(
          title: "Performa Budidayaa",
          subtitle: "Untuk menghitung biomassa SR, FCR pada budidaya",
          icon: Icons.vertical_split_outlined)
    ];

    final List<String> routeOptions = [
      AmoniaScreen.routeName,
      PerformaScreen.routeName
    ];

    return Scaffold(
      appBar: CustomAppBar(
        titleText: "Prediksi",
        textColors: AppColors.secondary,
        backGroundColor: AppColors.blueAccent,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AboutScreen.routeName),
              icon: const Icon(
                Icons.description_outlined,
                color: AppColors.secondary,
              ))
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.blueAccent, AppColors.primary],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(24.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PrediksiOption(
                          option: options[index],
                          routeName: routeOptions[index],
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}

class PrediksiOption extends StatelessWidget {
  const PrediksiOption(
      {super.key, required this.option, required this.routeName});

  final PrediksiOptionItem option;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Card(
        surfaceTintColor: AppColors.blueAccent.withValues(alpha: 0.1),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(
                option.icon,
                size: 36,
                color: AppColors.gradientStart,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.blueAccent),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            option.subtitle,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrediksiOptionItem {
  const PrediksiOptionItem(
      {required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final IconData icon;
}
