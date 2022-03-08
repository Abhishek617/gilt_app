import 'package:flutter/material.dart';
import 'package:guilt_app/constants/assets.dart';

class AppLogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const AppLogoWidget({Key? key,this.width = 200, this.height = 150}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.appLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

}