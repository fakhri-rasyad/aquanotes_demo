import 'package:aquanotes/features/add_alarm/data/source/add_alarm_remote_source.dart';
import 'package:aquanotes/features/add_alarm/domain/repository/add_alarm_repo.dart';
import 'package:aquanotes/shared/data/model/divais_response_model.dart';
import 'package:dartz/dartz.dart';

class AddAlarmRepoImpl implements AddAlarmRepo {
  final AddAlarmRemoteSource source;

  AddAlarmRepoImpl(this.source);

  @override
  Future<Either<String, List<DivaisResponseModel>>> getDivais() async {
    return source.getDivais();
  }
}
