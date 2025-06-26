import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/regist_response_model.dart';
import 'package:aquanotes/features/authentication/domain/repository/register_screen_repo.dart';
import 'package:dartz/dartz.dart';

class SendRegist
    extends Usecase<Future<Either<String, RegistResponseModel>>, RegistParam> {
  final RegisterScreenRepo repo;

  SendRegist(this.repo);

  @override
  Future<Either<String, RegistResponseModel>> call(RegistParam param) {
    return repo.sendRegist(param);
  }
}
