import 'package:flutter/material.dart';
import 'package:wall_e/forgot_password/screens/forgot_password.dart';
import 'package:wall_e/home_page/screens/home_page_screen.dart';
import 'package:wall_e/home_page/screens/zoomed_image_screen.dart';
import 'package:wall_e/login/screens/login_screen.dart';
import 'package:wall_e/profile/screens/profile_screen.dart';
import 'package:wall_e/register/screens/register_screen.dart';


class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/register';
  static const String homePage = '/homePage';
  static const String forgotPassword = '/forgotPassword';
  static const String zoomedImage = '/zoomedImage';
  static const String profilePage = "/profilePage";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late var values;
    if (settings.arguments != null) {
      values = settings.arguments as Map<String, dynamic>;
    }
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case registerPage:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        );
      case zoomedImage:
        return MaterialPageRoute(
          builder: (context) => ZoomedImageScreen(imageURL: values['imageURL'],),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ); 
      default:
        throw FormatException('Route Not Found!');
    }
  }
}
