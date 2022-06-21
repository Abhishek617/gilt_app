import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/stores/form/form_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool passenable = true;

  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());

  FocusNode? _passwordFocusNode;

  final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _userEmailController.text = 'chitra@phpdots.com';
    _passwordController.text = 'Jayshreeram@123';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: AppLogoWidget(
                    width: 140.0,
                    height: 140.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 20),
                  child: Text(
                    'Guilt App',
                    style: TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 20),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 30),
                  child: Container(
                    // height: 50,
                    width: 310,
                    child: TextFormField(
                      // controller: nameController,
                      controller: _userEmailController,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      onChanged: (value) {
                        _store.setUserId(_userEmailController.text);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                        labelText: 'Enter Mail',
                      ),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)) {
                          return "Enter a valid Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 310,
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onChanged: (value) {
                        _store.setPassword(_passwordController.text);
                      },
                      obscureText: passenable,
                      //This will obscure text dynamically
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password_sharp,
                        ),
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
                  padding: const EdgeInsets.only(left: 210, top: 10),
                  child: GestureDetector(
                      onTap: () {
                        Routes.navigateToScreen(
                            context, Routes.forgot_password);
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 20),
                  child: ElevatedButtonWidget(
                    buttonText: 'Login',
                    buttonColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        _userStore.login(_userEmailController.value.text,
                            _passwordController.value.text, (value) {

                          print("loginData: $value");
                          (value.success == true && value.user != null)
                              ? Routes.navigateRootToScreen(
                                  context, Routes.home_tab):

                          Routes.navigateToScreenWithArgs(
                              context,
                              Routes.otpvalidate,
                            _userEmailController.value.text
                            );

                        }, (error) {
                          print(error);
                          final data = json.decode(json.encode(error.data))
                              as Map<String, dynamic>;
                          // Map<String, dynamic> map = json.decode(error.data);
                          GlobalMethods.showErrorMessage(
                              context, data['message'], 'Log In Exception');
                        }).then((value) {
                          print(value);
                        });
                      } else {
                        print('Eroor');
                      }
                      //Routes.navigateToScreenWithArgs(context, Routes.success_error_validate,SuccessErrorValidationPageArgs(isSuccess: true, description: 'Logged in successfully', title: 'Success', isPreviousLogin: true));
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 5, top: 20),
                //   child: ElevatedButtonWidget(
                //     buttonText: 'Login Fail',
                //     buttonColor: Theme.of(context).colorScheme.primary,
                //     onPressed: () {
                //       Routes.navigateToScreenWithArgs(
                //           context,
                //           Routes.success_error_validate,
                //           SuccessErrorValidationPageArgs(
                //               isSuccess: false,
                //               description: 'Something went wrong',
                //               title: 'Error',
                //               isPreviousLogin: true));
                //     },
                //   ),
                // ),
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
                                text: ' Sign up',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontStyle: FontStyle.italic),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Routes.navigateToScreen(
                                        context, Routes.signup);
                                  })
                          ]),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Container(
                    width: 55.0,
                    height: 55.0,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/6956/6956877.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Face Recognition',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode?.dispose();
    super.dispose();
  }

   getSharedPreference() async {
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('firstname', 'firstname');
     await prefs.setString('lastname', 'lastname');
     await prefs.setString('email', 'email');


   }
}
