import 'package:dio/dio.dart';

class RegisterProvider {
  Future<String> RegisterUser(String fullname, String username, String password, String secretKey) async {
    var response = await Dio()
        .post('http://10.0.2.2:69/register?fullname=$fullname&username=$username&password=$password&secretKey=$secretKey');

    if (response.data['status'] == '') {
      return "Success";
    } else {
      return "Failure";
    }
  }
}
