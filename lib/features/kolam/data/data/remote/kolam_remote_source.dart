import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/kolam/data/model/kolam_req_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class KolamRemoteSource {
  Future<Either<String, KolamRespModel>> postKolam(KolamReqModel model);
  Future<Either<String, List<TambakResponseModel>>> getTambak();
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
}

class KolamRemoteSourceImpl implements KolamRemoteSource {
  final Dio dio;
  KolamRemoteSourceImpl(this.dio);
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
  Future<Either<String, KolamRespModel>> postKolam(KolamReqModel model) async {
    try {
      final response = await dio.post(
        EndPoints.kolamEndPoint,
        data: {
          "nama": model.nama,
          "tipe": model.tipe,
          "panjang": model.panjang,
          "lebar": model.lebar,
          "kedalaman": model.kedalaman,
          "komoditas": model.komoditas,
          "tambak_id": model.tambakId,
          "device_id": model.deviceId
        },
      );
      return right(KolamRespModel.fromJson(response.data));
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);
      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
