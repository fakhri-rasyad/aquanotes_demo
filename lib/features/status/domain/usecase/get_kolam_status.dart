import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/status/domain/repository/status_repo.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:dartz/dartz.dart';

class GetKolamStatus
    extends Usecase<Future<Either<String, List<KolamRespModel>>>, int> {
  final StatusRepo repo;
  GetKolamStatus(this.repo);
  @override
  Future<Either<String, List<KolamRespModel>>> call(int param) {
    return repo.getKolam(param);
  }
}
