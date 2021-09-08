import 'package:dio/dio.dart';
import 'package:wall_e/sharedPreference.dart';

class LoginProvider {
  Future<String> LoginUser(String username, String password) async {
    var response = await Dio()
        .get('http://10.0.2.2:69/login?username=$username&password=$password');

    if (response.data['status'] == '') {
      SaveLoginState(username);
      return "Success";
    } else {
      return "Failure";
    }
  }

  Future<String> SaveLoginState(String username) async {
    final _prefs = sharedPreference();
    var response = await _prefs.saveUsername(username);
    return response;
  }
}
