import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class StatusRemoteSource {
  Future<Either<String, List<TambakResponseModel>>> getTambak();
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId);
}

class StatusRemoteSourceImpl implements StatusRemoteSource {
  final Dio dio;
  StatusRemoteSourceImpl(this.dio);
  @override
  Future<Either<String, List<DivaisResponseModel>>> getDivais() async {
    try {
      final response = await dio.get(EndPoints.deviceEndPoint);

      final responseModelList = (response.data as List)
          .map((e) => DivaisResponseModel.fromJson(e))
          .toList();
      return right(responseModelList);
    } on DioException catch (e) {
      return left(
          e.response?.statusMessage ?? "Masalah saat mengembalikan data");
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId) async {
    try {
      final response = await dio.get(EndPoints.kolamEndPoint,
          queryParameters: {"tambak_id": tambakId});

      final responseModelList = (response.data as List)
          .map((e) => KolamRespModel.fromJson(e))
          .toList();
      return right(responseModelList);
    } on DioException catch (e) {
      return left(
          e.response?.statusMessage ?? "Masalah saat mengembalikan data");
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TambakResponseModel>>> getTambak() async {
    try {
      final response = await dio.get(EndPoints.tambakEndPoint);

      final responseModelList = (response.data as List)
          .map((e) => TambakResponseModel.fromJson(e))
          .toList();
      return right(responseModelList);
    } on DioException catch (e) {
      return left(
          e.response?.statusMessage ?? "Masalah saat mengembalikan data");
    } catch (e) {
      return left(e.toString());
    }
  }
}
