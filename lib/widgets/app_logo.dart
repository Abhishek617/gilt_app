import 'package:flutter/material.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/utils/device/device_utils.dart';

class AppLogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const AppLogoWidget({Key? key,this.width = 200, this.height = 150}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Container(
      width: DeviceUtils.getScaledWidth(context, 0.50),
      height: DeviceUtils.getScaledHeight(context, 0.25),
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.appLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

}