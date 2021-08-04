import 'package:flutter/material.dart';
import 'package:wall_e/pages/finishRegister.dart';
import 'package:wall_e/pages/forgotPassword.dart';
import 'package:wall_e/pages/login.dart';
import 'package:wall_e/pages/mainPage.dart';
import 'package:wall_e/pages/profile.dart';
import 'package:wall_e/pages/register.dart';
import 'package:wall_e/pages/resetPassword.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/register';
  static const String mainPage = '/mainPage';
  static const String finishRegister = '/finishRegister';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late var values;
    if (settings.arguments != null) {
      values = settings.arguments as Map<String, dynamic>;
    }
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => RegisterPage(),
        );
      case finishRegister:
        return MaterialPageRoute(
          builder: (context) => FinishRegister(
            fullname: values['fullname'],
            username: values['username'],
            password: values['password'],
          ),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ForgotPassword(),
        );
      case resetPassword:
        return MaterialPageRoute(
          builder: (context) => ResetPassword(
            username: values['username'],
          ),
        );
      case mainPage:
        return MaterialPageRoute(
          builder: (context) => MainPage(),
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) => Profile(),
        );
      default:
        throw FormatException('Route Not Found!');
    }
  }
}
