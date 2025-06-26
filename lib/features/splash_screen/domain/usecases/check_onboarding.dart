import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/splash_screen/domain/repository/splash_screen_repository.dart';

class CheckOnboarding extends Usecase<Future<bool>, NoParams> {
  final SplashScreenRepository repository;

  CheckOnboarding(this.repository);

  @override
  Future<bool> call(NoParams param) {
    return repository.checkOnboarding();
  }
}
