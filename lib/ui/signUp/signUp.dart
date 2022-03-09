import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';

import '../../widgets/rounded_button_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passenable = true;
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding, vertical: Dimens.vertical_padding),
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
                  'free guide will tell about the impact your gift will have',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 330,
                  child: TextField(
                    // controller: nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 162,
                      child: TextField(
                        // controller: nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: 'First Name', hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 162,
                      child: TextField(
                        // controller: nameController,
                        decoration: const InputDecoration(

                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 330,
                  child: TextField(
                    // controller: nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: 330,
                  child: TextField(
                    obscureText: passenable,
                    //if passenable == true, show **, else show password character
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                        labelText: "Password",
                        suffix: IconButton(
                            onPressed: () {
                              //add Icon button at end of TextField
                              setState(() {
                                //refresh UI
                                if (passenable) {
                                  //if passenable == true, make it false
                                  passenable = false;
                                } else {
                                  passenable =
                                  true; //if passenable == false, make it true
                                }
                              });
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Icon(
                                passenable == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ))
                      //eye icon if passenable = true, else, Icon is ***__
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 20),
                  child: ElevatedButtonWidget(
                    buttonText: 'Create Account',
                    buttonColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Routes.navigateToScreen(context, Routes.before_login);
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
                                        color: Colors.blueAccent, fontSize: 14,  decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Routes.navigateToScreen(context, Routes.login);
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
    );
  }
}
