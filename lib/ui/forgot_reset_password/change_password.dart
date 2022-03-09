import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class Change_password extends StatefulWidget {
  const Change_password({Key? key}) : super(key: key);

  @override
  _Change_passwordState createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            // Routes.navigateToScreen(context, Routes.welcome_login);
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
                padding: const EdgeInsets.only(top: 35),
                child: Container(
                  height: 50,
                  width: 310,
                  child: TextField(
                    obscureText: passenable,
                    //if passenable == true, show **, else show password character
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: OutlineInputBorder(),
                        hintText: "New Enter Password",
                        labelText: "Enter New Password",
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
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50,
                  width: 310,
                  child: TextField(
                    obscureText: passenable,
                    //if passenable == true, show **, else show password character
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        border: OutlineInputBorder(),
                        hintText: "Enter Confirm Password",
                        labelText: "Enter Confirm Password",
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
              SizedBox(
                height: 30,
              ),
              ElevatedButtonWidget(
                buttonColor: Theme.of(context).colorScheme.primary,
                buttonText: 'Change Password',
                onPressed: () {
                  Routes.navigateToScreen(context, Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
