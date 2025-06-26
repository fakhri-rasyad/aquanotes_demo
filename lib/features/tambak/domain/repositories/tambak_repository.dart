import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/data/model/error_response.dart';
import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:aquanotes/features/tambak/domain/entities/province.dart';
import 'package:dartz/dartz.dart';

abstract class TambakRepository {
  Future<List<Province>> getProvince();
  Future<Either<ErrorResponse, TambakResponseModel>> postTambak(
      TambakParam param);
}
