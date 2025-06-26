import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/profile/domain/usecase/get_credentials.dart';
import 'package:aquanotes/features/profile/domain/usecase/set_logout.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit(this.setLogout, this.getCredentials)
      : super(const ProfileScreenUpdate());

  final SetLogout setLogout;
  final GetCredentials getCredentials;

  Future<void> logOut() async {
    setLogout.call(NoParams());
    emit(const ProfileScreenUpdate());
  }

  Future<void> setUserCred() async {
    if (state.email != null) return;
    final credentials = await getCredentials(NoParams());
    emit(state.copyWith(email: credentials.email));
  }
}
