import 'package:dio/dio.dart';

class LoginProvider {
  Future<String> LoginUser(String username, String password) async {
    var response = await Dio()
        .get('http://10.0.2.2:69/login?username=$username&password=$password');

    if (response.data['status'] == '') {
      return "Success";
    } else {
      return "Failure";
    }
  }
}
