import 'package:wall_e/login/data_provider/data_provider.dart';
import 'package:wall_e/login/models/login_model.dart';

class LoginRepository {
  final LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  Future<String> LoginUser(LoginUserModel user) async {
    final String username = user.username;
    final String password = user.password;
    
    final result = await loginProvider.LoginUser(
      username,
      password,
    );
    return result;
  }
}
