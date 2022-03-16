
import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:guilt_app/utils/google_auth/gmail_auth.dart';
import 'package:guilt_app/ui/login/after_gmail_login.dart';



class WelcomeLogin extends StatefulWidget {
  const WelcomeLogin({Key? key}) : super(key: key);

  @override
  _WelcomeLoginState createState() => _WelcomeLoginState();
}

class _WelcomeLoginState extends State<WelcomeLogin> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: AppLogoWidget(
                  width: 200,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButtonWidget(
                buttonText: 'Log In',
                buttonColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Routes.navigateToScreen(context, Routes.before_login);
                },
              ),
              ElevatedButtonWidget(
                buttonColor: Theme.of(context).colorScheme.primary,
                buttonText: 'Sign Up',
                onPressed: () {
                  Routes.navigateToScreen(context, Routes.signup);
                },
              ),

              ElevatedButtonWidget(
                buttonColor: Theme.of(context).colorScheme.primary,
                buttonText: 'Continue With Gmail',
                onPressed: ()async {
                  await FirebaseServices().signInWithGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AfterGmailLogin()));
                },
              ),


              SizedBox(
                height: 130,
              ),
              GestureDetector(
                onTap: (){
                  Routes.navigateToScreen(context, Routes.privacy_policy);
                },
                child: Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,fontStyle: FontStyle.italic),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
