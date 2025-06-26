import 'package:aquanotes/features/authentication/data/model/regist_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:aquanotes/core/utils/usecase.dart';

abstract class RegisterScreenRepo {
  Future<Either<String, RegistResponseModel>> sendRegist(RegistParam param);
}
