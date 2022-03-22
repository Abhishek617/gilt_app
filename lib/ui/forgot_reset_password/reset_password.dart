import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';

import '../../constants/colors.dart';

class Reset_password extends StatefulWidget {
  const Reset_password({Key? key}) : super(key: key);

  @override
  _Reset_passwordState createState() => _Reset_passwordState();
}

class _Reset_passwordState extends State<Reset_password> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            // Routes.navigateToScreen(context, Routes.login);
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
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      'Guilt App',
                      style: TextStyle(
                        fontSize: 19.0,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.vertical_padding),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 30),
                  child: Container(
                    // height: 50,
                    width: 310,
                    child: TextFormField(
                      // controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail,),
                        border: OutlineInputBorder(),
                        labelText: 'Enter Mail',

                      ),
                      validator: (val){
                        if(val!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)){
                          return "Enter a valid Email";
                        }else{
                          return null;
                        }
                      },
                    ),
                  ),
                ),


                SizedBox(
                  height: 15,
                ),
                ElevatedButtonWidget(
                  buttonText: 'Reset Password',
                  buttonColor: AppColors.primaryColour,
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      Routes.navigateToScreen(context, Routes.otp);
                      }else{
                      print('Eroor');
                    }
                    //Routes.navigateToScreen(context, Routes.otp);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
