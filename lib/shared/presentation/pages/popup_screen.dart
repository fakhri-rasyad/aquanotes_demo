import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/shared/presentation/widgets/secondary_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class PopupScreen extends StatelessWidget {
  static const routeName = "/Popup";

  const PopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! ScreenArgument) {
      return const Scaffold(
        body: Center(
          child: Text('Invalid or missing arguments!'),
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          // Ensure content is centered horizontally and vertically
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.75, // Make the container take full width
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust size to content
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  args.asset,
                  semanticLabel: args.title,
                ),

                // Icon(
                //   args.icon,
                //   size: 64,
                //   semanticLabel: 'Icon representing ${args.title}',
                // ),
                const SizedBox(height: 16.0), // Add spacing
                Text(
                  args.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center, // Center align text
                ),
                const SizedBox(height: 8.0), // Add spacing
                Text(
                  args.subtitle,
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.mediumGray),
                  textAlign: TextAlign.center, // Center align text
                ),
                const SizedBox(height: 24.0), // Add spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(args.buttonConfig.length, (index) {
                    final button = args.buttonConfig[index];
                    return button.isMain
                        ? MainButton(
                            buttonText: button.text,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(button.route);
                            })
                        : SecondaryButton(
                            buttonText: button.text,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(button.route);
                            });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenArgument {
  final String title;
  final String subtitle;
  final List<ButtonConfig> buttonConfig;
  // final IconData icon;
  final String asset;

  ScreenArgument(
      {required this.title,
      required this.subtitle,
      // required this.icon,
      required this.buttonConfig,
      required this.asset});
}

class ButtonConfig {
  final String text;
  final String route;
  final bool isMain;

  const ButtonConfig(
      {required this.text, required this.route, required this.isMain});
}
