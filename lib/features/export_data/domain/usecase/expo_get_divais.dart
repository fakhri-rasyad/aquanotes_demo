import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/export_data/domain/repository/export_repo.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';

class ExpoGetDivais extends Usecase<
    Future<Either<String, List<DivaisResponseModel>>>, NoParams> {
  final ExportRepo repo;
  ExpoGetDivais(this.repo);
  @override
  Future<Either<String, List<DivaisResponseModel>>> call(NoParams param) {
    return repo.getDivais();
  }
}
