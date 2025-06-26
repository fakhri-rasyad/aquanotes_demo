import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/login_response_model.dart';
import 'package:aquanotes/features/authentication/data/source/remote/login_remote_source.dart';
import 'package:aquanotes/features/authentication/domain/repository/login_screen_repo.dart';
import 'package:dartz/dartz.dart';

import '../source/login_shared_pref.dart';

class LoginScreenRepoImpl implements LoginScreenRepo {
  final LoginSharedPref loginSharedPref;
  final LoginRemoteSource source;

  LoginScreenRepoImpl(this.loginSharedPref, this.source);

  @override
  Future<void> setLogin() async {
    loginSharedPref.setLogin();
  }

  @override
  Future<Either<String, LoginResponseModel>> sendLogin(LoginParam param) async {
    return source.sendLogin(param);
  }

  @override
  Future<void> saveLoginCredentials(
      String accessToken, String tokenType, String email, String password) {
    return loginSharedPref.saveLoginCredentials(
        accessToken, tokenType, email, password);
  }
}
