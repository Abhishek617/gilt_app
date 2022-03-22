import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

import '../../constants/colors.dart';

class Change_password extends StatefulWidget {
  const Change_password({Key? key}) : super(key: key);

  @override
  _Change_passwordState createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  bool passenable = true;
  bool passenable2 = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formkey,
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
                      width: 310,
                      child: TextFormField(
                        controller: pass,
                        keyboardType: TextInputType.text,
                        obscureText: passenable,//This will obscure text dynamically
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_sharp,),
                          border: OutlineInputBorder(),
                          labelText: 'Enter New Password',
                          hintText: 'Enter New password',
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passenable
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                if(passenable){
                                  passenable = false;
                                }else{
                                  passenable = true;
                                }
                              });
                            },
                          ),

                        ),
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter New password";
                          }else{
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
                        controller: confirmPass,
                        keyboardType: TextInputType.text,
                        obscureText: passenable2,//This will obscure text dynamically
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_sharp,),
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          hintText: 'Enter Confirm password',
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passenable2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                if(passenable2){
                                  passenable2 = false;
                                }else{
                                  passenable2 = true;
                                }
                              });
                            },
                          ),

                        ),
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Confirm password";
                          }if(val!= pass.text)
                            return 'Password Not Match';
                          return null;
                        },
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButtonWidget(
                    buttonColor: AppColors.primaryColour,
                    buttonText: 'Change Password',
                    onPressed: () {
                      if(formkey.currentState!.validate()){
                        Routes.navigateToScreen(context, Routes.login);
                      }else{
                        print('Eroor');
                      }
                     // Routes.navigateToScreen(context, Routes.login);
                    },
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
