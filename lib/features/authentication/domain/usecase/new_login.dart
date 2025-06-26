import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/login_response_model.dart';
import 'package:aquanotes/features/authentication/domain/repository/login_screen_repo.dart';
import 'package:dartz/dartz.dart';

class SendLogin
    extends Usecase<Future<Either<String, LoginResponseModel>>, LoginParam> {
  final LoginScreenRepo repo;
  SendLogin(this.repo);
  @override
  Future<Either<String, LoginResponseModel>> call(LoginParam param) {
    return repo.sendLogin(param);
  }
}
