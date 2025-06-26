import 'package:aquanotes/features/export_data/data/source/export_remote_source.dart';
import 'package:aquanotes/features/export_data/domain/repository/export_repo.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';

class ExportRepoImpl implements ExportRepo {
  final ExportRemoteSource source;

  ExportRepoImpl(this.source);

  @override
  Future<Either<String, List<DivaisResponseModel>>> getDivais() async {
    return source.getDivais();
  }

  @override
  Future<Either<String, List<TambakResponseModel>>> getTambak() async {
    return source.getTambak();
  }

  @override
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId) async {
    return source.getKolam(tambakId);
  }
}
