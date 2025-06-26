import 'package:aquanotes/features/divais/data/data/remote/divais_remote_source.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/divais/domain/repository/divais_repo.dart';
import 'package:dartz/dartz.dart';

class DivaisRepoImpl implements DivaisRepo {
  final DivaisRemoteSource source;

  DivaisRepoImpl(this.source);

  @override
  Future<Either<String, DivaisResponseModel>> postDivais(
      DivaisResponseModel model) async {
    return await source.postDivais(model);
  }
}
