import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/kolam/data/model/kolam_req_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:dartz/dartz.dart';

abstract class KolamScreenRepo {
  Future<Either<String, KolamRespModel>> postKolam(KolamReqModel model);
  Future<Either<String, List<TambakResponseModel>>> getTambak();
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
}
