import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/add_alarm/domain/repository/add_alarm_repo.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';

class AddAlarmGetDivais extends Usecase<
    Future<Either<String, List<DivaisResponseModel>>>, NoParams> {
  final AddAlarmRepo repo;
  AddAlarmGetDivais(this.repo);
  @override
  Future<Either<String, List<DivaisResponseModel>>> call(NoParams param) {
    return repo.getDivais();
  }
}
