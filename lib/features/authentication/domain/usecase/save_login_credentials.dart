import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/domain/repository/login_screen_repo.dart';

class SaveLoginCredentials extends Usecase<Future<void>, CredentialParam> {
  final LoginScreenRepo repo;
  SaveLoginCredentials(this.repo);
  @override
  Future<void> call(CredentialParam param) {
    return repo.saveLoginCredentials(
        param.accessToken, param.tokenType, param.email, param.password);
  }
}
