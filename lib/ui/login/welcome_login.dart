import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 220),
            child: Container(
              width: 160.0,
              height: 160.0,
              decoration: new BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://cdn-icons-png.flaticon.com/512/1177/1177568.png"),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 40),
            child: Container(
              height: 40.0,
              width: 320,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, (Route<dynamic> route) => false);
                  },
                  child: Text('Log In')),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18, top: 10),
            child: Container(
              height: 40.0,
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
            padding: const EdgeInsets.only(left: 18, top: 10),
            child: Container(
              height: 40.0,
              width: 320,
              child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Continue With Gmail')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 100),
            child: Text('Terms of Service', style: TextStyle(color: Colors.black),),
          ),

        ],
      ),

    );
  }
}
