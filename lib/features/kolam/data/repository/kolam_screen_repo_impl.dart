import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/kolam/data/data/remote/kolam_remote_source.dart';
import 'package:aquanotes/features/kolam/data/model/kolam_req_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/features/kolam/domain/repositry/kolam_screen_repo.dart';
import 'package:dartz/dartz.dart';

class KolamScreenRepoImpl implements KolamScreenRepo {
  final KolamRemoteSource kolamRemoteSource;
  KolamScreenRepoImpl(this.kolamRemoteSource);
  @override
  Future<Either<String, List<DivaisResponseModel>>> getDivais() async {
    return kolamRemoteSource.getDivais();
  }

  @override
  Future<Either<String, List<TambakResponseModel>>> getTambak() async {
    return kolamRemoteSource.getTambak();
  }

  @override
  Future<Either<String, KolamRespModel>> postKolam(KolamReqModel model) async {
    return kolamRemoteSource.postKolam(model);
  }
}
