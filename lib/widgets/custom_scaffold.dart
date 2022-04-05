import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/ui/common/menu_drawer.dart';
import 'package:guilt_app/utils/routes/routes.dart';

class ScaffoldWrapper extends StatefulWidget {
  ScaffoldWrapper(
      {Key? key,
      required this.child,
      required this.appBar,
      this.isTab = false,
      this.isMenu = false})
      : super(key: key);

  final Widget child;
  final AppBar appBar;
  bool isMenu = false;
  bool isTab = false;

  @override
  State<ScaffoldWrapper> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> {
  Widget IconWithText(icon, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 25,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 9, letterSpacing: 0.3),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.isMenu == true ? MenuDrawer() : null,
      backgroundColor: Colors.white,
      appBar: widget.appBar,
      floatingActionButton: widget.isTab == true
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              //Floating action button on Scaffold
              onPressed: () {
                //code to execute on button press
              },
              child: IconWithText(
                  Icons.calendar_month, 'Add Event'), //icon inside button
            )
          : null,
      floatingActionButtonLocation: widget.isTab == true
          ? FloatingActionButtonLocation.centerDocked
          : null,
      bottomNavigationBar: widget.isTab == true
          ? BottomAppBar(
              color: AppColors.primaryColor,
              //bottom navigation bar on scaffold
              shape: CircularNotchedRectangle(),
              //shape of notch
              notchMargin: 6,
              //notch margin between floating button and bottom appbar
              child: Row(
                //children inside bottom appbar
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.explore,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Routes.navigateToScreen(context, Routes.events_home);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Routes.navigateToScreen(context, Routes.events_home);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.question_answer_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Routes.navigateToScreen(context, Routes.message);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Routes.navigateToScreen(context, Routes.view_profile);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: Container(
        color: AppColors.primaryColor,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: Container(
            color: Colors.white,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
