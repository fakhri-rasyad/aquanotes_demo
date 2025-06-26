import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class StatusRepo {
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
  Future<Either<String, List<KolamRespModel>>> getKolam(int tambakId);
  Future<Either<String, List<TambakResponseModel>>> getTambak();
}
