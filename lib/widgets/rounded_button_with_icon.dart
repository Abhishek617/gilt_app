import 'package:flutter/material.dart';

import '../utils/device/device_utils.dart';

class ElevatedButtonWidgetWithIcon extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final Color iconColor;
  final icon;

  const ElevatedButtonWidgetWithIcon({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.06),
      width: DeviceUtils.getScaledWidth(context, 0.70),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        icon:Icon(Icons.add_a_photo_sharp, color: iconColor,),
        label: Text(buttonText, style: TextStyle(color: textColor,fontSize: 16,fontWeight: FontWeight.bold)),
        onPressed: onPressed,
      ),
    );
  }
}