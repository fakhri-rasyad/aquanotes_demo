import 'package:aquanotes/core/data/shared_preferences.dart/credentials_storage.dart';
import 'package:aquanotes/core/model/credentials.dart';

abstract class ProfileSharedPref {
  Future<void> setLogOut();
  Future<Credentials> getCred();
}

class ProfileSharedPrefImpl implements ProfileSharedPref {
  final CredentialsStorage credentialsStorage;

  ProfileSharedPrefImpl(this.credentialsStorage);

  @override
  Future<void> setLogOut() async {
    credentialsStorage.deleteCredentials();
  }

  @override
  Future<Credentials> getCred() async {
    return await credentialsStorage.getCredentials();
  }
}
