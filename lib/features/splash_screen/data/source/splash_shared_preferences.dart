import 'package:aquanotes/core/data/shared_preferences.dart/login_storage.dart';
import 'package:aquanotes/core/data/shared_preferences.dart/onboarding_storage.dart';

abstract class SplashSharedPreferences {
  Future<bool> checkOnboarding();
  Future<bool> checkLogin();
  Future<void> setOnboarding();
}

class SplashSharedPreferencesImpl implements SplashSharedPreferences {
  final LoginStorage loginStorage;
  final OnboardingStorage onboardingStorage;

  SplashSharedPreferencesImpl(this.loginStorage, this.onboardingStorage);

  @override
  Future<bool> checkLogin() async {
    final token = await loginStorage.isLoggedIn();

    return token != "" ? true : false;
  }

  @override
  Future<bool> checkOnboarding() async {
    return onboardingStorage.hasOnboarded();
  }

  @override
  Future<void> setOnboarding() async {
    onboardingStorage.setOnboarded();
  }
}
