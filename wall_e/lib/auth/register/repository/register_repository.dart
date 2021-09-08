import 'package:wall_e/auth/register/data_provider/data_provider.dart';
import 'package:wall_e/auth/register/models/register_model.dart';

class RegisterRepository {
  final RegisterProvider registerProvider;

  RegisterRepository({required this.registerProvider});

  Future<String> RegisterUser(RegisterUserModel user) async {
    final String fullname = user.fullname;
    final String username = user.username;
    final String password = user.password;
    final String secretKey = user.secretKey;

    final result = await registerProvider.RegisterUser(
      fullname,
      username,
      password,
      secretKey,
    );

    return result;
  }
}
