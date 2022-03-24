import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:guilt_app/ui/Intro_screens/intro_screen.dart';
import 'package:guilt_app/ui/Profile/profile.dart';
import 'package:guilt_app/ui/common/before_login_Screen.dart';
import 'package:guilt_app/ui/common/faqs.dart';
import 'package:guilt_app/ui/common/otp_screen.dart';
import 'package:guilt_app/ui/common/privacy_policy.dart';
import 'package:guilt_app/ui/common/success_error_validation.dart';
import 'package:guilt_app/ui/common/terms_conditions.dart';
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
  static const String success_error_validate = '/success_error_validate';
  static const String privacy_policy = '/privacy_policy';
  static const String terms_conditions = '/terms_conditions';
  static const String faqs = '/faqs';
  static const String prof = '/prof';


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
    success_error_validate: (BuildContext context) =>
        SuccessErrorValidateScreen(),
    privacy_policy: (BuildContext context) => Privacy_Policy(),
    terms_conditions: (BuildContext context) => Terms_Condition(),
    faqs: (BuildContext context) => FaqScreen(),
    prof: (BuildContext context) => Profile(),


  };

  static navigateToScreen(BuildContext context, route) {
    Navigator.of(context).pushNamed(route);
  }

  static navigateToScreenWithArgs(
      BuildContext context, route, successErrorValidationPageArgs) {
    Navigator.of(context)
        .pushNamed(route, arguments: successErrorValidationPageArgs);
  }

  static goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
