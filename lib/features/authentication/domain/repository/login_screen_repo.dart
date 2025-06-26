import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/login_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class LoginScreenRepo {
  Future<void> setLogin();
  Future<Either<String, LoginResponseModel>> sendLogin(LoginParam param);
  Future<void> saveLoginCredentials(
      String accessToken, String tokenType, String email, String passwod);
}
