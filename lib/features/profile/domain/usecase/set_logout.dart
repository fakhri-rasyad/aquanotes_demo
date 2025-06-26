import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/profile/domain/repository/profile_screen_repo.dart';

class SetLogout extends Usecase<Future<void>, NoParams> {
  final ProfileScreenRepo repo;

  SetLogout(this.repo);

  @override
  Future<void> call(NoParams param) async {
    repo.setLogout();
  }
}
