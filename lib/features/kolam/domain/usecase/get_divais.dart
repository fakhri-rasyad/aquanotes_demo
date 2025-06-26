import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/kolam/domain/repositry/kolam_screen_repo.dart';
import 'package:dartz/dartz.dart';

class GetDivais extends Usecase<
    Future<Either<String, List<DivaisResponseModel>>>, NoParams> {
  final KolamScreenRepo repo;

  GetDivais(this.repo);
  @override
  Future<Either<String, List<DivaisResponseModel>>> call(NoParams param) {
    return repo.getDivais();
  }
}
