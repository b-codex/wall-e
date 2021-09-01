import 'package:wall_e/login/models/login_model.dart';

abstract class LoginEvent {}

class AttemptLogin extends LoginEvent {
  final LoginUserModel user;
  AttemptLogin({required this.user});
}