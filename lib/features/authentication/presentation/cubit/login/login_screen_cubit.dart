import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/domain/usecase/new_login.dart';
import 'package:aquanotes/features/authentication/domain/usecase/save_login_credentials.dart';
import 'package:aquanotes/features/authentication/domain/usecase/set_login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(this.setLogin, this.sendLogin, this.saveLoginCredentials)
      : super(const LoginScreenUpdate());

  final SetLogin setLogin;
  final SendLogin sendLogin;
  final SaveLoginCredentials saveLoginCredentials;

  LoginScreenUpdate get current => state as LoginScreenUpdate;

  void resetInput() {
    emit(state.copyWith(email: "", password: "", showPassword: false));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateShowPassword() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void setLoginFunc() {
    setLogin.call(NoParams());
  }

  Future<void> saveCredentials(CredentialParam param) async {
    saveLoginCredentials.call(param);
  }

  Future<void> sendData() async {
    emit(LoginScreenLoading(current: current));
    // await Future.delayed(const Duration(seconds: 3));

    final loginParam = LoginParam(state.email, state.password);
    final result = await sendLogin.call(loginParam);

    result.fold((failure) {
      emit(LoginScreenError(current: current, message: failure));
    }, (model) {
      final credentials = CredentialParam(model.accessToken, model.tokenType,
          loginParam.email, loginParam.password);
      saveCredentials(credentials);
      emit(LoginScreenSuccess(current: current));
    });
  }
}
