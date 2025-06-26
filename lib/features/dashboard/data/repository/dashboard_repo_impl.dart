import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/dashboard/data/source/pref/dashboard_pref.dart';
import 'package:aquanotes/features/dashboard/data/source/remote/dashboard_remote_datasource.dart';
import 'package:aquanotes/features/dashboard/domain/repository/dashboard_repo.dart';
import 'package:dartz/dartz.dart';

class DashboardRepoImpl implements DashboardRepo {
  final DashboardRemoteDatasource remoteDatasource;
  final DashboardPref pref;

  DashboardRepoImpl(this.remoteDatasource, this.pref);

  @override
  Future<Either<String, List<TambakResponseModel>>> getTambakData() async {
    return remoteDatasource.getUserTambak();
  }
}
