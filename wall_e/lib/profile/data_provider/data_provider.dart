import 'package:dio/dio.dart';

class ProfileDataProvider {
  Future<Object> getPersonalInfo(String username) async {
    try {
      var response =
          await Dio().get('http://10.0.2.2:69/profile?username=$username');
      String fullname = response.data['fullname'];
      String password = response.data['password'];

      return {
        'status': 'Success',
        'fullname': fullname,
        'username': username,
        'password': password,
      };
    } on DioError catch (_) {
      return {'failed'};
    }
  }

  Future<String> savePersonalInfo(
      String fullname, String username, String password) async {
    try {
      var response = await Dio().post(
          'http://10.0.2.2:69/profile?fullname=$fullname&username=$username&password=$password');

      if (response.data['status'] == '') {
        return "Success";
      } else {
        return "Failure";
      }
    } on DioError catch (_) {
      return "API Error";
    }
  }

  Future<String> changePassword(
      String username, String password, String secret_key) async {
    try {
      var response = await Dio().post(
          'http://10.0.2.2:69/resetPassword?username=$username&password=$password&secretKey=$secret_key');
      if (response.data['status'] == '') {
        return "Success";
      } else {
        return 'Failure';
      }
    } on DioError catch (_) {
      return "API Error";
    }
  }

  Future<String> deleteAccount(String username) async {
    try {
      var response = await Dio().delete(
          'http://10.0.2.2:69/deleteAccount?username=$username');
      if (response.data['status'] == '') {
        return "Success";
      } else {
        return 'Failure';
      }
    } on DioError catch (_) {
      return "API Error";
    }
  }
}
