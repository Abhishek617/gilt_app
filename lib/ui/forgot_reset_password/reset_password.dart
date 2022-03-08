import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';

class Reset_password extends StatefulWidget {
  const Reset_password({Key? key}) : super(key: key);

  @override
  _Reset_passwordState createState() => _Reset_passwordState();
}

class _Reset_passwordState extends State<Reset_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_outlined,color: Colors.black, size: 15,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ) ,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140.0,
                height: 140.0,
                margin: EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: Dimens.vertical_padding,bottom: 50),
                  child: Text('Guilt App', style: TextStyle(fontSize: 19.0,),)),
              Padding(
                padding: EdgeInsets.only(top: Dimens.vertical_padding),
                child: Text('free guide will tell about the impact your gift will have', style: TextStyle(fontSize: 13.0,),),
              ),
              Container(
                height: 50,
                width: 320,
                margin: EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
                child:
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                ),
              ),
               Container(
                 height: 50,
                 width: 320,
                 margin: EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
                 child: ElevatedButtonWidget(
                   buttonText: 'Reset Password',
                     buttonColor: Colors.orangeAccent,
                     textColor: Colors.black,
                     onPressed: (){
                       Navigator.of(context).pushNamedAndRemoveUntil(
                           Routes.otp, (Route<dynamic> route) => false);
                     },
                     ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
