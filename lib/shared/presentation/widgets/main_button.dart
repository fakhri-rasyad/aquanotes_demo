import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  const MainButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gradientStart,
        foregroundColor: AppColors.secondary,
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
