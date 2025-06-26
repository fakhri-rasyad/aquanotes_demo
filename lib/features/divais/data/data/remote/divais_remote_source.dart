import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class DivaisRemoteSource {
  Future<Either<String, DivaisResponseModel>> postDivais(
      DivaisResponseModel model);
}

class DivaisRemoteSourceImpl implements DivaisRemoteSource {
  final Dio dio;

  DivaisRemoteSourceImpl(this.dio);

  @override
  Future<Either<String, DivaisResponseModel>> postDivais(
      DivaisResponseModel model) async {
    try {
      final response = await dio.post(EndPoints.deviceEndPoint, data: {
        "uid": model.uid,
        "name": model.name,
      });

      final responseModel = DivaisResponseModel.fromJson(response.data);

      return right(responseModel);
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
