import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/splash_screen/domain/usecases/check_login.dart';
import 'package:aquanotes/features/splash_screen/domain/usecases/check_onboarding.dart';
import 'package:aquanotes/features/splash_screen/domain/usecases/set_onboarding.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit(this.checkLogin, this.checkOnboarding, this.setOnboarding)
      : super(SplashScreenInitial());

  final CheckLogin checkLogin;
  final CheckOnboarding checkOnboarding;
  final SetOnboarding setOnboarding;

  Future<void> checkStatus() async {
    try {
      final hasLogin = await checkLogin(NoParams());
      final hasOnboard = await checkOnboarding(NoParams());

      if (hasLogin) {
        emit(SplashScreenOnLogin());
      } else if (hasOnboard) {
        emit(SplashScreenOnBoarding());
      } else {
        setOnboarding.call(NoParams());
        emit(SplashScreenNewUser());
      }
    } catch (e) {
      return;
    }
  }
}
