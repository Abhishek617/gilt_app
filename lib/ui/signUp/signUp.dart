import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/signup_modal.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';

import '../../constants/colors.dart';
import '../../models/PageModals/success_error_args.dart';
import '../../widgets/rounded_button_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool passenable = true;
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Routes.navigateToScreen(context, Routes.welcome_login);
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
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formkey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontal_padding,
                  vertical: Dimens.vertical_padding),
              child: Column(
                children: [
                  AppLogoWidget(
                    width: 140.0,
                    height: 140.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Guilt App',
                    style: TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: 330,
                    child: TextFormField(
                      controller: _userEmailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                        labelText: 'Enter Email',
                      ),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)) {
                          return "Enter a Valid Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        //height: 50,
                        width: 162,
                        child: TextFormField(
                          controller: _fNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            hintText: 'First Name',
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter valid First Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // height: 50,
                        width: 162,
                        child: TextFormField(
                          controller: _lNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Valid Last Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: 330,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp("[a-z']+"))
                      ],
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 330,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        obscureText: passenable,
                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password_sharp,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passenable
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                if (passenable) {
                                  passenable = false;
                                } else {
                                  passenable = true;
                                }
                              });
                            },
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter a valid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Create Account',
                      buttonColor: AppColors.primaryColour,
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          final signUpData = SignUpRequestModal.fromJson({
                            "firstname": _fNameController.value.text,
                            "lastname": _lNameController.value.text,
                            "email": _userEmailController.value.text,
                            "phone": _phoneNumberController.value.text,
                            "password": _passwordController.value.text,
                            "role_id": "2"
                          });
                          _userStore.signUp(signUpData, (val) {
                            print(val);
                            if (val.success) {
                              Routes.navigateToScreenWithArgs(
                                  context,
                                  Routes.success_error_validate,
                                  SuccessErrorValidationPageArgs(
                                      isSuccess: true,
                                      description: 'SignUp Success',
                                      title: 'Success',
                                      isPreviousLogin: true));
                            } else {
                              GlobalMethods.showErrorMessage(context,
                                  'Something went wrong', 'Sign Up Exception');
                            }
                          }, (error) {
                            print(error.data.toString());
                            final data = json.decode(json.encode(error.data))
                                as Map<String, dynamic>;
                            print(data['error']);
                            // Map<String, dynamic> map = json.decode(error.data);
                            List<dynamic> dataList = data["error"];
                            print(dataList[0]["message"]);
                            GlobalMethods.showErrorMessage(
                                context,
                                dataList[0]["field"] +
                                    ' : ' +
                                    dataList[0]["message"],
                                'Sign Up Exception');
                          });
                          // Routes.navigateToScreen(context, Routes.before_login);
                        } else {
                          print('Eroor');
                        }
                        // Routes.navigateToScreen(context, Routes.before_login);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Container(
                        child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign in',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Routes.navigateToScreen(
                                          context, Routes.login);
                                    })
                            ]),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
