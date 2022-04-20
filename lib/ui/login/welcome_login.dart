
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:guilt_app/utils/google_auth/gmail_auth.dart';
import 'package:guilt_app/ui/login/after_gmail_login.dart';

import '../../constants/colors.dart';
import '../../stores/user/user_store.dart';



class WelcomeLogin extends StatefulWidget {
  const WelcomeLogin({Key? key}) : super(key: key);

  @override
  _WelcomeLoginState createState() => _WelcomeLoginState();
}

class _WelcomeLoginState extends State<WelcomeLogin> {
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: AppLogoWidget(
                  width: 200,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButtonWidget(
                buttonText: 'Login',
                buttonColor: AppColors.primaryColor,
                onPressed: () {
                  Routes.navigateToScreen(context, Routes.login);
                },
              ),
              ElevatedButtonWidget(
                buttonColor: AppColors.primaryColor,
                buttonText: 'Sign Up',
                onPressed: () {
                  Routes.navigateToScreen(context, Routes.before_login);
                },
              ),

              ElevatedButtonWidget(
                buttonColor: AppColors.primaryColor,
                buttonText: 'Continue With Gmail',
                onPressed: ()async {
                  await FirebaseServices().signInWithGoogle();
                  if(FirebaseAuth.instance.currentUser!.email != null) {
                    _userStore.oauth(FirebaseAuth.instance.currentUser!.email as String, FirebaseAuth.instance.currentUser!.displayName as String, FirebaseAuth.instance.currentUser!.displayName as String, (value) {
                      Routes.navigateRootToScreen(context, Routes.events_home);
                      // Routes.navigateToScreenWithArgs(
                      //     context,
                      //     Routes.success_error_validate,
                      //     SuccessErrorValidationPageArgs(
                      //         isSuccess: true,
                      //         description: 'Logged in successfully',
                      //         title: 'Success',
                      //         isPreviousLogin: false));
                    },(error) {
                      print(error);
                      final data = json.decode(json.encode(error.data)) as Map<String, dynamic>;
                      // Map<String, dynamic> map = json.decode(error.data);
                      GlobalMethods.showErrorMessage(context,data['message'], 'Log In Exception');
                    }).then((value) {
                      print(value);
                    });
                    Routes.navigateRootToScreen(context, Routes.events_home);
                  }
                  print('error');
                },
              ),


              SizedBox(
                height: 130,
              ),
              GestureDetector(
                onTap: (){
                  Routes.navigateToScreen(context, Routes.privacy_policy);
                },
                child: Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,fontStyle: FontStyle.italic),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
