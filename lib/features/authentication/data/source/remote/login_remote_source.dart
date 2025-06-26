import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/login_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/data/remote/end_points.dart';

abstract class LoginRemoteSource {
  Future<Either<String, LoginResponseModel>> sendLogin(LoginParam param);
}

class LoginRemoteSourceImpl implements LoginRemoteSource {
  final Dio dio;

  LoginRemoteSourceImpl(this.dio);

  @override
  Future<Either<String, LoginResponseModel>> sendLogin(LoginParam param) async {
    try {
      final response = await dio.post(
        EndPoints.loginEndPoint,
        data: {
          "email": param.email,
          "password": param.password,
        },
      );
      // final mockData = LoginResponseModel("0000", "00000");

      return right(
          // mockData
          LoginResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
