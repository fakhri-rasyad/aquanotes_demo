import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final VoidCallback? onBackButton;
  final Color textColors;
  final Color backGroundColor;
  final bool showBackButton;

  const CustomAppBar(
      {super.key,
      required this.titleText,
      this.actions,
      this.backGroundColor = AppColors.secondary,
      this.textColors = AppColors.gradientStart,
      this.onBackButton,
      this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      backgroundColor: backGroundColor,
      centerTitle: true,
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColors,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: textColors),
              onPressed: () {
                if (onBackButton != null) {
                  onBackButton!();
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
      iconTheme: IconThemeData(color: textColors),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
