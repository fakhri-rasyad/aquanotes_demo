import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/status/domain/repository/status_repo.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';

class GetDivaisStatus extends Usecase<
    Future<Either<String, List<DivaisResponseModel>>>, NoParams> {
  final StatusRepo repo;
  GetDivaisStatus(this.repo);
  @override
  Future<Either<String, List<DivaisResponseModel>>> call(NoParams param) {
    return repo.getDivais();
  }
}
