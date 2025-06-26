import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/splash_screen/domain/repository/splash_screen_repository.dart';

class SetOnboarding extends Usecase<Future<void>, NoParams> {
  final SplashScreenRepository repository;

  SetOnboarding(this.repository);

  @override
  Future<void> call(NoParams param) async {
    repository.setOnboarding();
  }
}
