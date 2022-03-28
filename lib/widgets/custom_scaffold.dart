import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/ui/common/menu_drawer.dart';


class ScaffoldWrapper extends StatefulWidget{
  ScaffoldWrapper({Key? key, required this.child, required this.appBar,  this.isMenu = false}) : super(key: key);

  final Widget child;
  final AppBar appBar;
  bool isMenu = false;
  @override
  State<ScaffoldWrapper> createState() => _ScaffoldWrapperState();
}
class _ScaffoldWrapperState extends State<ScaffoldWrapper> {

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.isMenu == true ? MenuDrawer() : null,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: widget.appBar,

      body: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child:
        Container(
          color: Colors.white,
          child: widget.child,
        ),
      ),
    );
  }
}