import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AddAlarmRemoteSource {
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
}

class AddAlarmRemoteImpl implements AddAlarmRemoteSource {
  final Dio dio;
  const AddAlarmRemoteImpl(this.dio);
  @override
  Future<Either<String, List<DivaisResponseModel>>> getDivais() async {
    try {
      final response = await dio.get(EndPoints.deviceEndPoint);
      return right((response.data as List)
          .map((e) => DivaisResponseModel.fromJson(e))
          .toList());
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
