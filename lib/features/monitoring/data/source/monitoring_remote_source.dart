import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:aquanotes/core/utils/dio_exception_handler.dart';
import 'package:aquanotes/features/monitoring/data/model/monitor_resp_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MonitoringRemoteSource {
  Future<Either<String, MonitorRespModel>> getMonitoring();
}

class MonitoringRemoteSourceImpl implements MonitoringRemoteSource {
  final Dio dio;
  MonitoringRemoteSourceImpl(this.dio);
  @override
  Future<Either<String, MonitorRespModel>> getMonitoring() async {
    try {
      final response = await dio.get(EndPoints.monitoringEndPoint);
      final responseData = MonitorRespModel.fromJson(response.data);
      return right(responseData);
    } on DioException catch (e) {
      return left(DioExceptionHandler.handle(e));
    } catch (e) {
      return left(e.toString());
    }
  }
}
