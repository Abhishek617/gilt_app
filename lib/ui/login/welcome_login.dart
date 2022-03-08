import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: AppLogoWidget(
                  width: 200,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButtonWidget(
                  textColor: Colors.white,
                  buttonText: 'Log In',
                  buttonColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, (Route<dynamic> route) => false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButtonWidget(
                  textColor: Colors.white,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  buttonText: 'Sign Up',
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, (Route<dynamic> route) => false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButtonWidget(
                  textColor: Colors.white,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  buttonText: 'Continue With Gmail',
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
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
