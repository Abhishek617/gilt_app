import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.welcome_login, (Route<dynamic> route) => false);
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
                  'free guide will tell about the impact your gift will have',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 30),
                child: Container(
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
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, top: 15),
                    child: Container(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 15),
                    child: Container(
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 15),
                child: Container(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 20),
                child: ElevatedButtonWidget(
                  buttonText: 'Create Account',
                  buttonColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.after_login, (Route<dynamic> route) => false);
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
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          Routes.login, (Route<dynamic> route) => false);
                                    })
                            ]),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
