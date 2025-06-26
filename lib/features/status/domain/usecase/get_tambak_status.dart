import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/status/domain/repository/status_repo.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';

class GetTambakStatus extends Usecase<
    Future<Either<String, List<TambakResponseModel>>>, NoParams> {
  final StatusRepo repo;
  GetTambakStatus(this.repo);
  @override
  Future<Either<String, List<TambakResponseModel>>> call(NoParams param) {
    return repo.getTambak();
  }
}
