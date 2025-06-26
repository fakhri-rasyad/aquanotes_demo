import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/monitoring/data/model/monitor_resp_model.dart';
import 'package:aquanotes/features/monitoring/domain/repository/monitoring_repo.dart';
import 'package:dartz/dartz.dart';

class GetMonitoring
    extends Usecase<Future<Either<String, MonitorRespModel>>, NoParams> {
  final MonitoringRepo repo;

  GetMonitoring(this.repo);

  @override
  Future<Either<String, MonitorRespModel>> call(NoParams param) {
    return repo.getMonitoring();
  }
}
