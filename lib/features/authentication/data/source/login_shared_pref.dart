import 'package:aquanotes/core/data/shared_preferences.dart/credentials_storage.dart';
import 'package:aquanotes/core/data/shared_preferences.dart/login_storage.dart';

abstract class LoginSharedPref {
  Future<void> setLogin();
  Future<void> saveLoginCredentials(
      String accessToken, String tokenType, String email, String password);
}

class LoginSharedPrefImpl implements LoginSharedPref {
  final LoginStorage loginStorage;
  final CredentialsStorage credentialsStorage;
  LoginSharedPrefImpl(this.loginStorage, this.credentialsStorage);

  @override
  Future<void> setLogin() async {
    loginStorage.setLoggedIn(true);
  }

  @override
  Future<void> saveLoginCredentials(String accessToken, String tokenType,
      String email, String password) async {
    return credentialsStorage.saveCredentials(
        accessToken, tokenType, email, password);
  }
}
