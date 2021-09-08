import 'package:dio/dio.dart';
import 'package:wall_e/profile/models/profile_models.dart';
import 'package:wall_e/sharedPreference.dart';

class ProfileDataProvider {
  Future<Object> getPersonalInfo(String username) async {
    try {
      var response = await Dio(
        BaseOptions(
          connectTimeout: 5 * 1000,
        ),
      ).get('http://10.0.2.2:69/profile?username=$username');
      String fullname = response.data['fullname'];
      String password = response.data['password'];
      return {
        'status': 'Success',
        'fullname': fullname,
        'username': username,
        'password': password,
      };
    } on DioError catch (_) {
      return {'status' : 'failed'};
    }
  }

  Future<String> savePersonalInfo(
      SavePersonalInfoModel savePersonalInfoModel) async {
    try {
      late String oldUsername;
      final _prefs = sharedPreference();
      await _prefs.getUsername().then(
        (value) {
          oldUsername = value;
        },
      );

      String username = savePersonalInfoModel.username;
      String fullname = savePersonalInfoModel.fullname;
      String password = savePersonalInfoModel.password;

      var response = await Dio().put(
          'http://10.0.2.2:69/profile?fullname=$fullname&username=$username&oldUsername=$oldUsername&password=$password');

      if (response.data['status'] == '') {
        await _prefs.saveUsername(username);
        return "Success";
      } else {
        return "Failure";
      }
    } on DioError catch (_) {
      return "API Error";
    }
  }

  Future<String> changePassword(ChangePasswordModel changePasswordModel) async {
    try {
      String username = changePasswordModel.username;
      String password = changePasswordModel.password;
      String secret_key = changePasswordModel.secret_key;

      var response = await Dio().put(
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
      var response = await Dio()
          .delete('http://10.0.2.2:69/deleteAccount?username=$username');
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
