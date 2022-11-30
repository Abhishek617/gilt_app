import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/ui/common/menu_drawer.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
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
  bool isChatBadge = false;
  String badgeCount = '1';

  refreshBadge() {
    setState(() {
      isChatBadge = GlobalStoreHandler.userStore.isChatBadge;
      badgeCount = GlobalStoreHandler.userStore.chatBadgeCount;
    });
  }

  Widget iconWithText(icon, text, isBadge, {double fontSize = 10}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isBadge && isChatBadge
              ? Badge(
                  badgeColor: AppColors.orange_app,
                  badgeContent: Text(
                    badgeCount,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.white,
                ),
          Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          )
        ],
      );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: widget.isMenu == true ? MenuDrawer() : null,
      appBar: widget.appBar,
      // floatingActionButton: widget.isTab == true
      //     ? FloatingActionButton(
      //         backgroundColor: AppColors.primaryColor,
      //         //Floating action button on Scaffold
      //         onPressed: () {
      //           //code to execute on button press
      //           Routes.navigateToScreen(context, Routes.create_event);
      //         },
      //         child: iconWithText(Icons.calendar_month, 'Add Event', false,
      //             fontSize: 8), //icon inside button
      //       )
      //     : null,
      // floatingActionButtonLocation: widget.isTab == true
      //     ? FloatingActionButtonLocation.centerDocked
      //     : null,
      // bottomNavigationBar: widget.isTab == true
      //     ? BottomAppBar(
      //         color: AppColors.primaryColor,
      //         //bottom navigation bar on scaffold
      //         shape: CircularNotchedRectangle(),
      //         //shape of notch
      //         notchMargin: 4,
      //         //notch margin between floating button and bottom appbar
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             //children inside bottom appbar
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               InkWell(
      //                 onTap: () {
      //                   Routes.navigateToScreen(context, Routes.explore_home);
      //                 },
      //                 child: iconWithText(Icons.explore, 'Explore', false),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   Routes.navigateToScreen(context, Routes.wallet);
      //                 },
      //                 child: iconWithText(
      //                     Icons.account_balance_wallet, 'Wallet', false),
      //               ),
      //               SizedBox(
      //                 width: DeviceUtils.getScaledWidth(context, 0.20),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   Routes.navigateToScreen(context, Routes.message);
      //                 },
      //                 child: iconWithText(
      //                     Icons.question_answer_rounded, 'Chat', true),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   Routes.navigateToScreen(context, Routes.view_profile);
      //                 },
      //                 child: iconWithText(
      //                     Icons.account_circle_rounded, 'Profile', false),
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     : null,
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
