abstract class SplashScreenRepository {
  Future<bool> checkOnboarding();
  Future<bool> checkLogin();
  Future<void> setOnboarding();
}
