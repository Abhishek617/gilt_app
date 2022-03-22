import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:http/http.dart';

import '../../constants/colors.dart';


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
                  'Lorem ipsum dolor sit amet,',
                  style: TextStyle(
                    fontSize: 13.0,
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
                padding: const EdgeInsets.only(top: 25),
                child: ElevatedButtonWidget(
                  buttonColor: AppColors.primaryColour,
                  buttonText: 'Business Owner',
                  onPressed: () {
                    Routes.navigateToScreen(context, Routes.prof);
                  },
                ),
              ),
              ElevatedButtonWidget(
                buttonText: 'Individual User',
                buttonColor: AppColors.primaryColour,
                onPressed: () {
                  Routes.navigateToScreen(context, Routes.prof);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
