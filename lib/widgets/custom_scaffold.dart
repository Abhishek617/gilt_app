import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/dimens.dart';

class ScaffoldWrapper extends StatelessWidget{
  const ScaffoldWrapper({Key? key, required this.child, required this.appBar}) : super(key: key);

  final Widget child;
  final AppBar appBar;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child:
        Container(
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}