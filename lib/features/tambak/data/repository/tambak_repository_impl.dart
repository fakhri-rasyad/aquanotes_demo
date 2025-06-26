import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/error_response.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/tambak/data/source/tambak_local_datasource.dart';
import 'package:aquanotes/features/tambak/data/source/tambak_remote_datasource.dart';
import 'package:aquanotes/features/tambak/domain/entities/province.dart';
import 'package:aquanotes/features/tambak/domain/repositories/tambak_repository.dart';
import 'package:dartz/dartz.dart';

class TambakRepositoryImpl implements TambakRepository {
  final TambakLocalDatasource _localDataSource;
  final TambakRemoteDatasource _tambakRemoteDatasource;

  TambakRepositoryImpl(this._localDataSource, this._tambakRemoteDatasource);

  @override
  Future<List<Province>> getProvince() async {
    final models = await _localDataSource.getAllProvinces();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Either<ErrorResponse, TambakResponseModel>> postTambak(
      TambakParam param) {
    return _tambakRemoteDatasource.postTambak(param);
  }
}
