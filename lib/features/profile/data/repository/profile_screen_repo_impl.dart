import 'package:aquanotes/core/model/credentials.dart';
import 'package:aquanotes/features/profile/data/source/profile_remote_source.dart';
import 'package:aquanotes/features/profile/data/source/profile_shared_pref.dart';

import '../../domain/repository/profile_screen_repo.dart';

class ProfileScreenRepoImpl implements ProfileScreenRepo {
  final ProfileSharedPref profileSharedPref;
  final ProfileRemoteSource profileRemoteSourc;

  ProfileScreenRepoImpl(this.profileSharedPref, this.profileRemoteSourc);

  @override
  Future<void> setLogout() async {
    profileSharedPref.setLogOut();
    profileRemoteSourc.remoteLogout();
  }

  @override
  Future<Credentials> getCreds() async {
    return profileSharedPref.getCred();
  }
}
