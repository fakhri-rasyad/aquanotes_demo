import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class RectangularAvatar extends StatelessWidget {
  final String imageLink;
  final VoidCallback onPressed;
  final bool isEmpty;

  const RectangularAvatar(
      {super.key,
      required this.imageLink,
      required this.onPressed,
      required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: AppColors.secondary, width: 4),
              borderRadius: BorderRadius.circular(8.0), // Rounded square corner
              // image: DecorationImage(
              //   image: AssetImage(imageLink), // Replace with your image asset
              //   fit: BoxFit.cover,
              // ),
            ),
            child: const Icon(
              size: 48,
              Icons.person,
              color: AppColors.blueAccent,
            ),
          ),
          isEmpty
              ? const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.gradientStart,
                  child: Icon(
                    Icons.add,
                    size: 16,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
