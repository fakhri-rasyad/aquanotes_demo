import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/export_data/domain/repository/export_repo.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';

class ExpoGetTambak extends Usecase<
    Future<Either<String, List<TambakResponseModel>>>, NoParams> {
  final ExportRepo repo;
  ExpoGetTambak(this.repo);
  @override
  Future<Either<String, List<TambakResponseModel>>> call(NoParams param) {
    return repo.getTambak();
  }
}
