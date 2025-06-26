import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class SecondaryButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  const SecondaryButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.gradientStart,
        padding: const EdgeInsets.all(16.0),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.gradientStart)),
      ),
      child: Text(buttonText),
    );
  }
}
