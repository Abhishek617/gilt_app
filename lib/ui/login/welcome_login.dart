import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
class WelcomeLogin extends StatefulWidget {
  const WelcomeLogin({Key? key}) : super(key: key);

  @override
  _WelcomeLoginState createState() => _WelcomeLoginState();
}

class _WelcomeLoginState extends State<WelcomeLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
               padding: EdgeInsets.only(top: 60),
                child: Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://img.icons8.com/officel/344/person-male.png"),
                      fit: BoxFit.cover,
                  ),
                ),
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 50.0,
                  width: 320,
                  child:ElevatedButtonWidget(
                    textColor: Colors.white,
                      buttonText: 'Login',
                      buttonColor: Colors.orange,
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.login, (Route<dynamic> route) => false);
                      },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50.0,
                  width: 320,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.login, (Route<dynamic> route) => false);
                      },
                      child: Text('Sign Up')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 50.0,
                  width: 320,
                  child: ElevatedButton(
                      onPressed: (){},
                      child: Text('Continue With Gmail')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Terms of Service', style: TextStyle(color: Colors.black),),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
