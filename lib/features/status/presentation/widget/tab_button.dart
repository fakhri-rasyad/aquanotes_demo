// Widget _buildTabButton(
//     String label,
//     bool isSelected,
//     String icon,
//     VoidCallback changeTab,
//   ) {

//   }

import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.icon,
    required this.changeTab,
  });

  final String label;
  final bool isSelected;
  final String icon;
  final VoidCallback changeTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => changeTab(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: Colors.blue.withAlpha(127),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(icon,
                      height: 24.0,
                      color: isSelected ? Colors.white : Colors.blue),
                  const SizedBox(height: 5),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.secondary
                          : AppColors.gradientStart,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
