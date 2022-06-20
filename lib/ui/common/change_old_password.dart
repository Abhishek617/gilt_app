import 'package:flutter/material.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../constants/colors.dart';

class ChangeOldPassword extends StatefulWidget {
  const ChangeOldPassword({Key? key}) : super(key: key);

  @override
  _ChangeOldPasswordState createState() => _ChangeOldPasswordState();
}

class _ChangeOldPasswordState extends State<ChangeOldPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool oldPassEnable = true;
  bool newPassEnable = true;
  bool confirmPassEnable = true;
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldWrapper(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              // Routes.navigateToScreen(context, Routes.welcome_login);
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 15,
            ),
          ),
          title: Text('Change Password'),
          centerTitle: true,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        AppLogoWidget(
                          width: 140.0,
                          height: 140.0,
                        ),
                        Text(
                          'Guilt App',
                          style: TextStyle(
                            fontSize: 19.0,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: DeviceUtils.getScaledWidth(context, 0.80),
                          child: TextFormField(
                            controller: oldPassword,
                            keyboardType: TextInputType.text,
                            obscureText: oldPassEnable,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_sharp,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Enter Old Password',
                              hintText: 'Enter Old password',
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  oldPassEnable
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    if (oldPassEnable) {
                                      oldPassEnable = false;
                                    } else {
                                      oldPassEnable = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Old password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: DeviceUtils.getScaledWidth(context, 0.80),
                          child: TextFormField(
                            controller: newPassword,
                            keyboardType: TextInputType.text,
                            obscureText: newPassEnable,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_sharp,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Enter New Password',
                              hintText: 'Enter New password',
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  newPassEnable
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    if (newPassEnable) {
                                      newPassEnable = false;
                                    } else {
                                      newPassEnable = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter New password";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: DeviceUtils.getScaledWidth(context, 0.80),
                          child: TextFormField(
                            controller: confirmPassword,
                            keyboardType: TextInputType.text,
                            obscureText: confirmPassEnable,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_sharp,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Enter Confirm Password',
                              hintText: 'Enter Confirm password',
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  confirmPassEnable
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    if (confirmPassEnable) {
                                      confirmPassEnable = false;
                                    } else {
                                      confirmPassEnable = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Confirm password";
                              }
                              if (val != newPassword.text)
                                return 'Password Not Match';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButtonWidget(
                          buttonColor: AppColors.primaryColor,
                          buttonText: 'Change Password',
                          onPressed: () {
                            _userStore
                                .changePassword(
                                    oldPassword.text, newPassword.text)
                                .then((value) {
                              print(value);
                              if (value.success == true) {
                                GlobalMethods.showSuccessMessage(
                                    context, value.message, 'Success');
                                Routes.navigateToScreen(
                                    context, Routes.view_profile);
                              } else {
                                GlobalMethods.showErrorMessage(
                                    context, value.message ?? "Something went wrong", 'Change password');
                              }
                            }).onError((error, stackTrace) {
                              print(error);
                            });
                            // if(formkey.currentState!.validate()){
                            //   Routes.navigateToScreen(context, Routes.login);
                            // }else{
                            //   print('Eroor');
                            // }
                            // Routes.navigateToScreen(context, Routes.login);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
