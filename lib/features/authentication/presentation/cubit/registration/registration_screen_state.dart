part of 'registration_screen_cubit.dart';

abstract class RegistrationScreenState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;

  const RegistrationScreenState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.role = "",
  });

  RegistrationScreenState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? role,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
        role,
      ];
}

class RegistrationScreenUpdate extends RegistrationScreenState {
  const RegistrationScreenUpdate({
    super.name,
    super.email,
    super.password,
    super.confirmPassword,
    super.role,
  });

  @override
  RegistrationScreenUpdate copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? role,
  }) {
    return RegistrationScreenUpdate(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
    );
  }
}

class RegistrationScreenLoading extends RegistrationScreenUpdate {
  RegistrationScreenLoading({required RegistrationScreenUpdate current})
      : super(
            name: current.name,
            email: current.email,
            password: current.password,
            confirmPassword: current.confirmPassword,
            role: current.role);
  @override
  List<Object?> get props => [...super.props];
}

class RegistrationScreenError extends RegistrationScreenUpdate {
  final String message;
  RegistrationScreenError(
      {required RegistrationScreenUpdate current, required this.message})
      : super(
            name: current.name,
            email: current.email,
            password: current.password,
            confirmPassword: current.confirmPassword,
            role: current.role);

  @override
  List<Object?> get props => [...super.props, message];
}

class RegistrationScreenSuccess extends RegistrationScreenUpdate {
  RegistrationScreenSuccess({required RegistrationScreenUpdate current})
      : super(
            name: current.name,
            email: current.email,
            password: current.password,
            confirmPassword: current.confirmPassword,
            role: current.role);
}
