import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/constants/strings.dart';
import 'package:guilt_app/ui/Event/create_event.dart';
import 'package:guilt_app/ui/Messages/message.dart';
import 'package:guilt_app/ui/Profile/full_profile.dart';
import 'package:guilt_app/ui/home/home_explore_screen.dart';
import 'package:guilt_app/ui/common/menu_drawer.dart';
import 'package:guilt_app/ui/payment/wallet.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var currentIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  List<Widget> items = [];
  var screens = [];

  @override
  initState() {
    GlobalStoreHandler.userStore.getProfile();
    // tabSetup();
    super.initState();
  }

  @override
  didChangeDependencies() {
    tabSetup();
    super.didChangeDependencies();
  }

  tabSetup() {
    items = [
      iconWithText(Icons.explore, Strings.explore, false),
      iconWithText(Icons.account_balance_wallet, Strings.wallet, false),
      iconWithText(Icons.calendar_month, Strings.addEvent, false),
      iconWithText(Icons.question_answer_rounded, Strings.chat, true),
      iconWithText(Icons.account_circle_rounded, Strings.profile, false),
    ];
    screens = [
      HomeExploreScreen(),
      Wallet(),
      Create_event(),
      Messages(),
      FullProfile(),
    ];
  }

  Widget iconWithText(icon, text, isBadge, {double fontSize = 10}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Observer(
              builder: (BuildContext context) =>
                  isBadge && GlobalStoreHandler.userStore.isChatBadge
                      ? Badge(
                          badgeColor: AppColors.orange_app,
                          badgeContent: Text(
                            GlobalStoreHandler.userStore.chatBadgeCount,
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
                        )),
          Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          )
        ],
      );

  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Scaffold(
              drawer: MenuDrawer(),
              backgroundColor: Colors.white,
              extendBody: true,
              //appBar: widget.appBar,
              bottomNavigationBar: CurvedNavigationBar(
                  height: 60,
                  backgroundColor: Colors.transparent,
                  buttonBackgroundColor: AppColors.primaryColor,
                  color: AppColors.primaryColor,
                  index: currentIndex,
                  onTap: (index) => setState(() {
                        currentIndex = index;
                        tabSetup();
                      }),
                  items: items),
              body: screens[currentIndex],
            ));
  }
}
