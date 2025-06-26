import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/export_data/domain/repository/export_repo.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:dartz/dartz.dart';

class ExpoGetKolam
    extends Usecase<Future<Either<String, List<KolamRespModel>>>, int> {
  final ExportRepo repo;
  ExpoGetKolam(this.repo);
  @override
  Future<Either<String, List<KolamRespModel>>> call(int param) {
    return repo.getKolam(param);
  }
}
