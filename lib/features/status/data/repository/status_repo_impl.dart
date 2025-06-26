import 'package:aquanotes/features/status/data/source/remote/status_remote_source.dart';
import 'package:aquanotes/features/status/domain/repository/status_repo.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';

class StatusRepoImpl implements StatusRepo {
  final StatusRemoteSource source;

  StatusRepoImpl(this.source);

  @override
  Future<Either<String, List<DivaisResponseModel>>> getDivais() async {
    return source.getDivais();
  }

  @override
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId) {
    return source.getKolam(tambakId);
  }

  @override
  Future<Either<String, List<TambakResponseModel>>> getTambak() {
    return source.getTambak();
  }
}
