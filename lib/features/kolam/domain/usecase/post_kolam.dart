import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/kolam/data/model/kolam_req_model.dart';
import 'package:aquanotes/shared/data/model/kolam_resp_model.dart';
import 'package:aquanotes/features/kolam/domain/repositry/kolam_screen_repo.dart';
import 'package:dartz/dartz.dart';

class PostKolam
    extends Usecase<Future<Either<String, KolamRespModel>>, KolamReqModel> {
  final KolamScreenRepo repo;

  PostKolam(this.repo);

  @override
  Future<Either<String, KolamRespModel>> call(KolamReqModel param) async {
    return repo.postKolam(param);
  }
}
