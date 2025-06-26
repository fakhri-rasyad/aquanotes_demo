import 'package:aquanotes/features/monitoring/data/model/monitor_resp_model.dart';
import 'package:dartz/dartz.dart';

abstract class MonitoringRepo {
  Future<Either<String, MonitorRespModel>> getMonitoring();
}
