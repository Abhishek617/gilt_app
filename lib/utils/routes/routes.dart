import 'package:guilt_app/ui/Intro_screens/intro_screen.dart';
import 'package:guilt_app/ui/common/before_login_Screen.dart';
import 'package:guilt_app/ui/common/otp_screen.dart';
import 'package:guilt_app/ui/forgot_reset_password/change_password.dart';
import 'package:guilt_app/ui/forgot_reset_password/reset_password.dart';
import 'package:guilt_app/ui/home/home.dart';
import 'package:guilt_app/ui/login/welcome_login.dart';
import 'package:guilt_app/ui/login/login.dart';
import 'package:guilt_app/ui/signUp/signUp.dart';
import 'package:guilt_app/ui/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String welcome_login = '/welcome_login';
  static const String before_login = '/before_login';
  static const String home = '/home';
  static const String intro = '/intro';
  static const String forgot_password = '/forgot_password';
  static const String reset_password = '/reset_password';
  static const String otp = '/otp';
  static const String signup = '/signup';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    intro: (BuildContext context) => OnBoardingPage(),
    welcome_login: (BuildContext context) => WelcomeLogin(),
    before_login: (BuildContext context) => Before_LoginScreen(),
    login: (BuildContext context) => Login(),
    home: (BuildContext context) => HomeScreen(),
    otp: (BuildContext context) => Otp_screen(),
    forgot_password: (BuildContext context) => Reset_password(),
    reset_password: (BuildContext context) => Change_password(),
    signup: (BuildContext context) => SignUp(),
  };

  static navigateToScreen(BuildContext context, route) {
    Navigator.of(context).pushNamed(route);
  }

  static goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
