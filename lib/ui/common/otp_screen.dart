import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class Otp_screen extends StatefulWidget {
  const Otp_screen({Key? key}) : super(key: key);

  @override
  _Otp_screenState createState() => _Otp_screenState();
}

class _Otp_screenState extends State<Otp_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: Icon(
          Icons.arrow_back_ios_outlined,color: Colors.black, size: 15,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) ,
      body:
        SingleChildScrollView(
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
                  padding: const EdgeInsets.only( top: 20),
                  child: Text('Guilt App', style: TextStyle(fontSize: 19.0,),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('free guide will tell about the impact your gift will have', style: TextStyle(fontSize: 13.0,),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 70,
                    width: 200,
                    child: OtpTextField(
                      numberOfFields: 4,
                      //borderColor: Color(0xFF512DA8),
                      showFieldAsBox: false, //set to true to show as box or false to show as dash
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                        //https://pub.dev/packages/flutter_otp_text_field

                      },
                      onSubmit: (String verificationCode){

                      }, // end onSubmit
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButtonWidget(
                    textColor: Colors.black,
                      buttonColor: Colors.orangeAccent,
                      buttonText: 'Continue',
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.reset_password, (Route<dynamic> route) => false);
                      },
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Link here', style: TextStyle(fontSize: 12.0,),),
                ),

              ],
            ),
          ),
        ),
      );

  }
}
