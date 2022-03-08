import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';

class Reset_password extends StatefulWidget {
  const Reset_password({Key? key}) : super(key: key);
  @override
  _Reset_passwordState createState() => _Reset_passwordState();
}
class _Reset_passwordState extends State<Reset_password> {
  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login, (Route<dynamic> route) => false);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,color: Colors.black, size: 15,),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) ,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppLogoWidget(
                  width: 140.0,
                  height: 140.0,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top:3),
                  child: Text('Guilt App', style: TextStyle(fontSize: 19.0,),)),

              Padding(
                padding: EdgeInsets.only(top: Dimens.vertical_padding),
                child: Text('free guide will tell about the impact your gift will have', style: TextStyle(fontSize: 13.0,),),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                width: 320,
                margin: EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
                child:
                TextField(
                  obscureText: passenable, //if passenable == true, show **, else show password character
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_sharp),
                      border: OutlineInputBorder(
                      ),
                      hintText: "New Enter Password",
                      labelText: "Enter New Password",
                      suffix: IconButton(onPressed: (){ //add Icon button at end of TextField
                        setState(() { //refresh UI
                          if(passenable){ //if passenable == true, make it false
                            passenable = false;
                          }else{
                            passenable = true; //if passenable == false, make it true
                          }
                        });
                      }, icon: Padding(
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
              SizedBox(
                height: 15,
              ),
               ElevatedButtonWidget(
                 buttonText: 'Reset Password',
                 buttonColor: Theme.of(context).colorScheme.primary,
                   textColor: Colors.black,
                   onPressed: (){
                     Navigator.of(context).pushNamedAndRemoveUntil(
                         Routes.otp, (Route<dynamic> route) => false);
                   },
                   ),
            ],
          ),
        ),
      ),
    );
  }
}
