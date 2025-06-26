import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/regist_response_model.dart';
import 'package:aquanotes/features/authentication/data/source/remote/regist_remote_source.dart';
import 'package:aquanotes/features/authentication/domain/repository/register_screen_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterScreenRepoImpl implements RegisterScreenRepo {
  final RegistRemoteSource source;
  RegisterScreenRepoImpl(this.source);
  @override
  Future<Either<String, RegistResponseModel>> sendRegist(
      RegistParam param) async {
    return source.sendRegist(param);
  }
}
