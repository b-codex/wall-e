abstract class LoginState {}

class LoggedOut extends LoginState {}

class LoggedIn extends LoginState {}

class LoginProgress extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}
