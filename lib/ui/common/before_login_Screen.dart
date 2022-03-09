import 'package:flutter/material.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class Before_LoginScreen extends StatefulWidget {
  const Before_LoginScreen({Key? key}) : super(key: key);

  @override
  _Before_LoginScreenState createState() => _Before_LoginScreenState();
}

class _Before_LoginScreenState extends State<Before_LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: AppLogoWidget(
                  width: 160.0,
                  height: 160.0,
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
                  'free guide will tell about the ',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'free guide will tell about the impact your gift will have',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ElevatedButtonWidget(
                  buttonColor: Theme.of(context).colorScheme.primary,
                  buttonText: 'Business Owner',
                  onPressed: () {
                    Routes.navigateToScreen(context, Routes.login);
                  },
                ),
              ),
              ElevatedButtonWidget(
                buttonText: 'Individual User',
                buttonColor: Theme.of(context).colorScheme.primary,
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
