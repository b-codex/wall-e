import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class CheckStatus extends LoginState {
  @override
  List<Object?> get props => [];
}

class CheckingStatus extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoggedOut extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoggedIn extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginProgress extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});

  @override
  List<Object?> get props => [this.message];
}
