part of 'login_screen_cubit.dart';

@immutable
abstract class LoginScreenState extends Equatable {
  final String email;
  final String password;
  // final String msg;
  // final bool isSuccess;
  final bool showPassword;
  // final bool showLoading;
  // final bool showDialog;

  const LoginScreenState({
    this.password = "",
    this.email = "",
    // this.msg = "",
    // this.showDialog = false,
    // this.isSuccess = false,
    this.showPassword = false,
    // this.showLoading = false,
  });
  LoginScreenState copyWith({
    String? email,
    String? password,
    // String? msg,
    // bool? showDialog,
    // bool? isSuccess,
    bool? showPassword,
    // bool? showLoading,
  });
  @override
  List<Object?> get props => [
        password, email,
        // msg,
        // isSuccess,
        showPassword,
        // showLoading,
        showDialog
      ];
}

class LoginScreenUpdate extends LoginScreenState {
  const LoginScreenUpdate({
    super.email,
    super.password,
    // super.msg,
    // super.showDialog,
    // super.isSuccess,
    super.showPassword,
    // super.showLoading,
  });
  @override
  LoginScreenState copyWith({
    String? email,
    String? password,
    // String? msg,
    // bool? showDialog,
    // bool? isSuccess,
    bool? showPassword,
    // bool? showLoading
  }) {
    return LoginScreenUpdate(
      email: email ?? this.email,
      password: password ?? this.password,
      // msg: msg ?? this.msg,
      // showDialog: showDialog ?? this.showDialog,
      // isSuccess: isSuccess ?? this.isSuccess,
      showPassword: showPassword ?? this.showPassword,
      // showLoading: showLoading ?? this.showLoading,
    );
  }
}

class LoginScreenLoading extends LoginScreenUpdate {
  LoginScreenLoading({required LoginScreenUpdate current})
      : super(
          email: current.email,
          password: current.password,
          showPassword: current.showPassword,
        );
  @override
  List<Object?> get props => [...super.props];
}

class LoginScreenError extends LoginScreenUpdate {
  final String message;
  LoginScreenError({required LoginScreenUpdate current, required this.message})
      : super(
            email: current.email,
            password: current.password,
            showPassword: current.showPassword);
  @override
  List<Object?> get props => [...super.props, message];
}

class LoginScreenSuccess extends LoginScreenUpdate {
  LoginScreenSuccess({
    required LoginScreenUpdate current,
  }) : super(
            email: current.email,
            password: current.password,
            showPassword: current.showPassword);
  @override
  List<Object?> get props => [...super.props];
}
