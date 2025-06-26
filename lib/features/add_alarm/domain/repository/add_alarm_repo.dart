import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddAlarmRepo {
  Future<Either<String, List<DivaisResponseModel>>> getDivais();
}
