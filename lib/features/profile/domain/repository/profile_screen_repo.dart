import 'package:aquanotes/core/model/credentials.dart';

abstract class ProfileScreenRepo {
  Future<void> setLogout();

  Future<Credentials> getCreds();
}
