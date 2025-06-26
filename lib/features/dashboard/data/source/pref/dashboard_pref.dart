import 'package:aquanotes/core/data/shared_preferences.dart/credentials_storage.dart';
import 'package:aquanotes/core/model/credentials.dart';

abstract class DashboardPref {
  Future<Credentials> getCredentials();
}

class DashboardPrefImpl extends DashboardPref {
  CredentialsStorage storage;
  DashboardPrefImpl(this.storage);
  @override
  Future<Credentials> getCredentials() {
    return storage.getCredentials();
  }
}
