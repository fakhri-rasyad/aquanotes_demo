import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/splash_screen/domain/repository/splash_screen_repository.dart';

class CheckLogin extends Usecase<Future<bool>, NoParams> {
  final SplashScreenRepository repository;
  CheckLogin(this.repository);

  @override
  Future<bool> call(NoParams param) async {
    return repository.checkLogin();
  }
}
