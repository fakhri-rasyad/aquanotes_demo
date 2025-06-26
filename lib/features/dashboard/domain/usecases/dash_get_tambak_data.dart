import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/dashboard/domain/repository/dashboard_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/usecase.dart';

class DashGetTambakData extends Usecase<
    Future<Either<String, List<TambakResponseModel>>>, NoParams> {
  final DashboardRepo repository;
  DashGetTambakData(this.repository);
  @override
  Future<Either<String, List<TambakResponseModel>>> call(NoParams param) {
    return repository.getTambakData();
  }
}
