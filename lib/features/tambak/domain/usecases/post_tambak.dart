import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/error_response.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/tambak/domain/repositories/tambak_repository.dart';
import 'package:dartz/dartz.dart';

class PostTambak extends Usecase<
    Future<Either<ErrorResponse, TambakResponseModel>>, TambakParam> {
  final TambakRepository repo;

  PostTambak(this.repo);
  @override
  Future<Either<ErrorResponse, TambakResponseModel>> call(TambakParam param) {
    return repo.postTambak(param);
  }
}
