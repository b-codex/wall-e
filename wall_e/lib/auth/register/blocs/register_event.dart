import 'package:wall_e/auth/register/models/register_model.dart';

abstract class RegisterEvent {}

class AttemptRegister extends RegisterEvent {
  final RegisterUserModel user;
  AttemptRegister({required this.user});
}
