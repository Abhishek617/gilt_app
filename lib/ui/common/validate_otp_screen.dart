import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/otpvalidatemodel.dart';

import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import '../../constants/colors.dart';

class Otp_Validate_Screen extends StatefulWidget {
  const Otp_Validate_Screen({Key? key}) : super(key: key);

  @override
  _Otp_Validate_ScreenState createState() => _Otp_Validate_ScreenState();
}

class _Otp_Validate_ScreenState extends State<Otp_Validate_Screen> {
  ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  var otpCode;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Routes.goBack(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
            size: 15,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: AppLogoWidget(
                    width: 140.0,
                    height: 140.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Guilt App',
                    style: TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 70,
                    width: 200,
                    child: OtpTextField(
                      keyboardType: TextInputType.number,
                      numberOfFields: 4,
                      //borderColor: Color(0xFF512DA8),
                      showFieldAsBox: false,
                      //set to true to show as box or false to show as dash

                      onCodeChanged: (String code) {
                        //handle validation or checks here
                        //https://pub.dev/packages/flutter_otp_text_field
                      },
                      onSubmit: (String verificationCode) {
                        setState(() {
                          otpCode = verificationCode;
                        });
                      }, // end onSubmit
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButtonWidget(
                      buttonColor: AppColors.primaryColor,
                      buttonText: 'Continue',
                      onPressed: () {
                        _userStore.OtpValidate(args, otpCode,
                                (OtpValidateModel value) {
                              Routes.navigateToScreenWithArgs(
                                  context, Routes.reset_password, args);
                              //Routes.navigateToScreenWithArgs(context, Routes.success_error_validate,SuccessErrorValidationPageArgs(isSuccess: true, description: 'Logged in successfully', title: 'Success', isPreviousLogin: true));
                            }, (error) {
                              print(error);
                              final data = json.decode(json.encode(error.data));
                              // Map<String, dynamic> map = json.decode(error.data);
                              GlobalMethods.showErrorMessage(
                                  context, data['error'], 'Forgot Password');
                            }).then((value) {
                          print(value);
                        });
                        // Routes.navigateToScreen(context, Routes.reset_password);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
