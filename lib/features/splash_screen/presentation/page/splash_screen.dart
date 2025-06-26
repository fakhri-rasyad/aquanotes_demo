import 'package:aquanotes/features/introduction/presentation/page/introduction_screen.dart';
import 'package:aquanotes/features/welcome/presentation/page/welcome_screen.dart';
import 'package:aquanotes/features/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:aquanotes/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/splash_screen_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = "/";

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  bool _navigated = false;

  void _onAnimationComplete() {
    context.read<SplashScreenCubit>().checkStatus();
  }

  void _navigateOnce(String route) {
    if (!_navigated && mounted) {
      _navigated = true;
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenOnLogin) {
            _navigateOnce(HomeScreen.routeName);
          } else if (state is SplashScreenOnBoarding) {
            _navigateOnce(WelcomeScreen.routeName);
          } else if (state is SplashScreenNewUser) {
            _navigateOnce(IntroductionScreen.routeName);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
            ),
          ),
          child: Center(
            child: AnimatedCircle(onComplete: _onAnimationComplete),
          ),
        ),
      ),
    );
  }
}

class AnimatedCircle extends StatelessWidget {
  final VoidCallback onComplete;

  const AnimatedCircle({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 3),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        if (value == 1.0) {
          Future.microtask(() => onComplete());
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(5, (index) {
              double size = 150 * (6 - index).toDouble() * value;
              return OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.gradientStart,
                        AppColors.gradientEnd,
                      ],
                    ),
                  ),
                ),
              );
            }),
            Image.asset(
              'assets/images/aerasea_logo.png',
              width: 254,
              height: 254,
              fit: BoxFit.cover,
            ),
          ],
        );
      },
    );
  }
}
