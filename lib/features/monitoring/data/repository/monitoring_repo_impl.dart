import 'package:aquanotes/features/monitoring/data/model/monitor_resp_model.dart';
import 'package:aquanotes/features/monitoring/data/source/monitoring_remote_source.dart';
import 'package:aquanotes/features/monitoring/domain/repository/monitoring_repo.dart';
import 'package:dartz/dartz.dart';

class MonitoringRepoImpl implements MonitoringRepo {
  final MonitoringRemoteSource source;

  MonitoringRepoImpl(this.source);

  @override
  Future<Either<String, MonitorRespModel>> getMonitoring() {
    return source.getMonitoring();
  }
}
