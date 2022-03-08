import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ElevatedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onPressed ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     // color: buttonColor,
     // shape: StadiumBorder(),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
      ),
    );
  }
}
