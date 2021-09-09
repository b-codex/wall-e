import 'package:dio/dio.dart';
import 'package:wall_e/auth/forgot_password/models/fp_model.dart';

class FP_Provider {
  Future<String> ResetPassword(FP_Model fp_model) async {
    String username = fp_model.username;
    String password = fp_model.password;
    String secret_key = fp_model.secretKey;
    try {
      var response = await Dio(
        BaseOptions(
          connectTimeout: 5 * 1000,
        ),
      ).put(
          'http://10.0.2.2:69/resetPassword?username=$username&password=$password&secretKey=$secret_key');

      print(response);
      if (response.data['status'] == '') {
        return "Success";
      }
      if (response.data['status'] == 'Account Not Found') {
        return response.data['status'];
      } else {
        return "Failure";
      }
    } on DioError catch (_) {
      return "API Error";
    }
  }
}
