import 'package:aquanotes/core/model/credentials.dart';
import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/profile/domain/repository/profile_screen_repo.dart';

class GetCredentials extends Usecase<Future<Credentials>, NoParams> {
  final ProfileScreenRepo repo;
  GetCredentials(this.repo);
  @override
  Future<Credentials> call(NoParams param) {
    return repo.getCreds();
  }
}
