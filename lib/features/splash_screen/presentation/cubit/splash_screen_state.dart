part of 'splash_screen_cubit.dart';

sealed class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

final class SplashScreenInitial extends SplashScreenState {}

final class SplashScreenOnBoarding extends SplashScreenState {}

final class SplashScreenOnLogin extends SplashScreenState {}

final class SplashScreenNewUser extends SplashScreenState {}
