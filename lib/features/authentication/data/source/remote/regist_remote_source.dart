import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/features/authentication/data/model/regist_response_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/core/data/remote/end_points.dart';

abstract class RegistRemoteSource {
  Future<Either<String, RegistResponseModel>> sendRegist(RegistParam param);
}

class RegistRemoteSourceImpl implements RegistRemoteSource {
  final Dio dio;

  RegistRemoteSourceImpl(this.dio);
  @override
  Future<Either<String, RegistResponseModel>> sendRegist(
      RegistParam param) async {
    try {
      final response = await dio.post(
        EndPoints.registEndPoint,
        data: {
          "name": param.name,
          "email": param.email,
          "password": param.password,
        },
      );
      return right(RegistResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
