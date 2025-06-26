import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ExportRemoteSource {
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
  Future<Either<String, List<TambakResponseModel>>> getTambak();
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId);
}

class ExportRemoteSourceImpl implements ExportRemoteSource {
  final Dio dio;
  const ExportRemoteSourceImpl(this.dio);
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

  @override
  Future<Either<String, List<TambakResponseModel>>> getTambak() async {
    try {
      final response = await dio.get(EndPoints.tambakEndPoint);
      return right((response.data as List)
          .map((e) => TambakResponseModel.fromJson(e))
          .toList());
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId) async {
    try {
      final response = await dio.get(EndPoints.kolamEndPoint,
          queryParameters: {"tambak_id": tambakId});
      return right((response.data as List)
          .map((e) => KolamRespModel.fromJson(e))
          .toList());
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
