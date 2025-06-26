import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:aquanotes/features/divais/domain/entity/divais_entity.dart';
import 'package:aquanotes/features/divais/domain/repository/divais_repo.dart';
import 'package:dartz/dartz.dart';

class PostDivais
    extends Usecase<Future<Either<String, DivaisResponseModel>>, DivaisEntity> {
  final DivaisRepo repo;
  PostDivais(this.repo);
  @override
  Future<Either<String, DivaisResponseModel>> call(DivaisEntity param) {
    final model = DivaisResponseModel(0, param.name, param.uid);
    return repo.postDivais(model);
  }
}
