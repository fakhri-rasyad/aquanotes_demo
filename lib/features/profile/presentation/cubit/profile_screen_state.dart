part of 'profile_screen_cubit.dart';

abstract class ProfileScreenState extends Equatable {
  final String? username;
  final String? email;
  const ProfileScreenState({this.email, this.username});

  ProfileScreenState copyWith({
    String? username,
    String? email,
  });

  @override
  List<Object?> get props => [username, email];
}

class ProfileScreenUpdate extends ProfileScreenState {
  const ProfileScreenUpdate({super.username, super.email});

  @override
  ProfileScreenState copyWith({String? username, String? email}) {
    return ProfileScreenUpdate(
        email: email ?? this.email, username: username ?? this.username);
  }
}
