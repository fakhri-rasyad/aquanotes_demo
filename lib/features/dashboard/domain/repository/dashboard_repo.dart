import 'package:aquanotes/shared/data/model/tambak_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepo {
  Future<Either<String, List<TambakResponseModel>>> getTambakData();
}
