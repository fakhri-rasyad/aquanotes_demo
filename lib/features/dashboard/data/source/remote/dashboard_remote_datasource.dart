import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class DashboardRemoteDatasource {
  Future<Either<String, List<TambakResponseModel>>> getUserTambak();
}

class DashBoardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final Dio dio;
  DashBoardRemoteDatasourceImpl(this.dio);
  @override
  Future<Either<String, List<TambakResponseModel>>> getUserTambak() async {
    try {
      final response = await dio.get(EndPoints.tambakEndPoint);

      final List<TambakResponseModel> tambakList = [];

      for (var e in (response.data as List)) {
        tambakList.add(TambakResponseModel.fromJson(e));
      }

      return right(tambakList);
    } on DioException catch (e) {
      final message = DioExceptionHandler.handle(e);

      return left(message);
    } catch (e) {
      return left(e.toString());
    }
  }
}
