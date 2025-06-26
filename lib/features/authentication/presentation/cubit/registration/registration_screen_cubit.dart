import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/authentication/domain/usecase/send_regist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_screen_state.dart';

class RegistrationScreenCubit extends Cubit<RegistrationScreenState> {
  RegistrationScreenCubit(this.sendRegist)
      : super(const RegistrationScreenUpdate());

  final SendRegist sendRegist;

  RegistrationScreenUpdate get current => state as RegistrationScreenUpdate;

  void resetInput() {
    emit(current.copyWith(
        name: "", email: "", password: "", confirmPassword: "", role: ""));
  }

  void updateName(String? name) {
    emit(current.copyWith(name: name));
  }

  void updateEmail(String? email) {
    emit(current.copyWith(email: email));
  }

  void updatePassword(String? password) {
    emit(current.copyWith(password: password));
  }

  void updateConfirmPassword(String? confirmPassword) {
    emit(current.copyWith(confirmPassword: confirmPassword));
  }

  void updateRole(String? role) {
    emit(current.copyWith(role: role));
  }

  Future<void> sendData() async {
    emit(RegistrationScreenLoading(current: current));
    final param = RegistParam(current.name, current.email, current.password);
    final result = await sendRegist(param);

    result.fold(
      (failure) {
        emit(RegistrationScreenError(current: current, message: failure));
      },
      (model) {
        emit(RegistrationScreenSuccess(current: current));
      },
    );
  }
}
