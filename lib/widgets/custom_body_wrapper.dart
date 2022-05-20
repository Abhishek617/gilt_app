import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';

class CustomBodyWrapper extends StatefulWidget {
  const CustomBodyWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<CustomBodyWrapper> createState() => _CustomBodyWrapperState();
}

class _CustomBodyWrapperState extends State<CustomBodyWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.only(bottom: 80),
          color: Colors.white,
          child: widget.child,
        ),
      ),
    );
  }
}
