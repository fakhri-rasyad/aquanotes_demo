import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/kolam/domain/repositry/kolam_screen_repo.dart';
import 'package:dartz/dartz.dart';

class GetTambak extends Usecase<
    Future<Either<String, List<TambakResponseModel>>>, NoParams> {
  final KolamScreenRepo repo;

  GetTambak(this.repo);
  @override
  Future<Either<String, List<TambakResponseModel>>> call(NoParams param) {
    return repo.getTambak();
  }
}
