import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border.all(color: AppColors.gradientStart, width: 8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nikmati Fitur Premium AI-QUANOTES",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Fitur Analisis Berbasis Kecerdasan Buatan akan membuat kamu bisa optimalkan budidaya dengan AI",
                    style: TextStyle(color: AppColors.xanthous),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.xanthous,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    onPressed: () {
                      // Navigate to another page or perform an action
                    },
                    child: const Text(
                      "Pelajari Selengkapnya",
                      style: TextStyle(color: AppColors.gradientEnd),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                "assets/images/home/dashboard/banner/1.png",
                fit: BoxFit
                    .cover, // Ensures the image covers the entire container height
              ),
            ),
          ),
        ],
      ),
    );
  }
}
