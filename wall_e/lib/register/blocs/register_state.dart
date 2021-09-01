abstract class RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterProgress extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure({required this.message});
}

class RegisterIdle extends RegisterState{}