import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/domain/repository/login_screen_repo.dart';

class SetLogin extends Usecase<Future<void>, NoParams> {
  final LoginScreenRepo repo;
  SetLogin(this.repo);

  @override
  Future<void> call(NoParams param) async {
    repo.setLogin();
  }
}
