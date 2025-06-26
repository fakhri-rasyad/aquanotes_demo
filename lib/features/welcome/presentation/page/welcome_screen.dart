import 'package:aquanotes/features/authentication/presentation/page/login_screen.dart';
import 'package:aquanotes/features/authentication/presentation/page/registration_screen.dart';
import 'package:aquanotes/shared/presentation/widgets/main_button.dart';
import 'package:aquanotes/shared/presentation/widgets/secondary_button.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/welcome/3.png')),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.gradientStart, AppColors.gradientEnd])),
        child: Stack(
          children: [
            const Image(image: AssetImage('assets/images/welcome/3.png')),
            Column(
              children: [
                Expanded(
                    child: Image(
                        width: MediaQuery.of(context).size.width * 0.6,
                        image:
                            const AssetImage('assets/images/welcome/2.png'))),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                      color: AppColors.secondary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Center buttons vertically
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 24.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Selamat Datang di",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          AppColors
                                              .gradientStart, // Start color
                                          AppColors.gradientEnd, // End color
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds);
                                    },
                                    child: const Text(
                                      "AQUANOTES",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors
                                            .white, // Set text color to white for the gradient effect
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Aplikasi manajemen budidaya perikanan berbasis Artificial intelligence terintegrasi Internet of Things",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    child: MainButton(
                                        buttonText: "Daftar Akun",
                                        onPressed: () => Navigator.of(context)
                                            .pushNamed(
                                                RegistrationScreen.routeName))),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: SecondaryButton(
                                        buttonText: "Sudah Memiliki Akun",
                                        onPressed: () => Navigator.of(context)
                                            .pushNamed(LoginScreen.routeName))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
