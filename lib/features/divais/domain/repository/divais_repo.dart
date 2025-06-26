import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class DivaisRepo {
  Future<Either<String, DivaisResponseModel>> postDivais(
      DivaisResponseModel model);
}
