import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/error_response.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TambakRemoteDatasource {
  Future<Either<ErrorResponse, TambakResponseModel>> postTambak(
      TambakParam param);
}

class TambakRemoteDataSourceImpl implements TambakRemoteDatasource {
  final Dio dio;

  TambakRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<ErrorResponse, TambakResponseModel>> postTambak(
      TambakParam param) async {
    try {
      final response = await dio.post(EndPoints.tambakEndPoint, data: {
        "name": param.name,
        "country": param.country,
        "province": param.province,
        "city": param.city,
        "district": param.district,
        "village": param.village,
        "address": param.address,
        "cultivation_type": param.cultivationType,

//   "country": "string",
//   "province": "string",
//   "city": "string",
//   "district": "string",
//   "village": "string",
//   "address": "string",
//   "cultivation_type": "string"
// }
      });

      final responseModel = TambakResponseModel.fromJson(response.data);

      return right(responseModel);
    } on DioException catch (e) {
      final data = e.response?.data;
      final statusCode = e.response?.statusCode;

      String message = "";

      if (statusCode == 422) {
        message = "Terdapat nilai yang kurang";
      }

      if (data is Map<String, dynamic>) {
        final detail = data['detail'];

        if (detail is String) {
          message = detail;
        } else if (detail is List && detail.isNotEmpty) {
          final first = detail.first;
          if (first is Map<String, dynamic> && first.containsKey("msg")) {
            message = first["msg"];
          }
        }
      }

      return left(ErrorResponse(message, code: statusCode));
    } catch (e) {
      return left(ErrorResponse("Unexpected error: ${e.toString()}"));
    }
  }
}
