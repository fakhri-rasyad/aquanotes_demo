import 'package:aquanotes/features/splash_screen/data/source/splash_shared_preferences.dart';
import 'package:aquanotes/features/splash_screen/domain/repository/splash_screen_repository.dart';

class SplashScreenRepositoryImpl implements SplashScreenRepository {
  final SplashSharedPreferences sharedPreferences;

  SplashScreenRepositoryImpl(this.sharedPreferences);

  @override
  Future<bool> checkLogin() async {
    return sharedPreferences.checkLogin();
  }

  @override
  Future<bool> checkOnboarding() async {
    return sharedPreferences.checkOnboarding();
  }

  @override
  Future<void> setOnboarding() async {
    sharedPreferences.setOnboarding();
  }
}
