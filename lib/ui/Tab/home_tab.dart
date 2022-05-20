  import 'package:curved_navigation_bar/curved_navigation_bar.dart';
  import 'package:flutter/material.dart';
  import 'package:guilt_app/constants/strings.dart';
  import 'package:guilt_app/ui/Business/add_business.dart';
  import 'package:guilt_app/ui/Profile/full_profile.dart';
  import 'package:guilt_app/ui/home/home_explore_screen.dart';
  import 'package:guilt_app/ui/common/menu_drawer.dart';
  import 'package:guilt_app/ui/forgot_reset_password/change_password.dart';
  import 'package:guilt_app/ui/forgot_reset_password/reset_password.dart';
  import 'package:guilt_app/ui/login/login.dart';
  import 'package:guilt_app/ui/signUp/signUp.dart';

  import '../../constants/app_settings.dart';
  import '../../constants/colors.dart';
  import '../../data/repository.dart';
  import '../../di/components/service_locator.dart';
  import '../../main.dart';
  import '../../stores/user/user_store.dart';
  import '../Event/create_event.dart';
  import '../Messages/message.dart';
  import '../Profile/profile.dart';
  import '../payment/wallet.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_messaging/firebase_messaging.dart';
  import 'package:flutter_local_notifications/flutter_local_notifications.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
  import 'package:flutter_mobx/flutter_mobx.dart';
  import 'package:guilt_app/constants/colors.dart';
  import 'package:guilt_app/data/repository.dart';
  import 'package:guilt_app/di/components/service_locator.dart';
  import 'package:guilt_app/models/Auth/profile_modal.dart';
  import 'package:guilt_app/models/Event/upcoming_past_event_modal.dart';
  import 'package:guilt_app/stores/user/user_store.dart';
  import 'package:guilt_app/utils/Global_methods/global.dart';
  import 'package:guilt_app/utils/device/device_utils.dart';
  import 'package:guilt_app/widgets/custom_body_wrapper.dart';
  import 'package:guilt_app/widgets/custom_scaffold.dart';
  import 'package:guilt_app/widgets/rounded_button_widget.dart';
  import 'package:mobx/mobx.dart';
  import 'package:provider/provider.dart';
  import '../common/menu_drawer.dart';
  import 'package:guilt_app/utils/routes/routes.dart';




  class HomeTab extends StatefulWidget {
    const HomeTab({Key? key}) : super(key: key);
    @override
    State<HomeTab> createState() => _HomeTabState();
  }

  class _HomeTabState extends State<HomeTab> {
    final UserStore _userStore = UserStore(getIt<Repository>());
    var currentIndex = 0;
    final navigationKey = GlobalKey<CurvedNavigationBarState>();
    List<Widget> items = [];
    var screens = [];

    @override
    initState() {
      super.initState();

      items = [
        iconWithText(Icons.explore, Strings.explore),
        iconWithText(Icons.account_balance_wallet, Strings.wallet),
        iconWithText(
            Icons.calendar_month,
            _userStore.getUserRole() == AppSettings.businessUserRole
                ? Strings.addEvent
                : Strings.booking),
        iconWithText(Icons.question_answer_rounded, Strings.chat),
        iconWithText(Icons.account_circle_rounded, Strings.profile),
      ];

      screens = [
        HomeExploreScreen(),
        Wallet(),
        _userStore.getUserRole() == AppSettings.businessUserRole
            ? Create_event()
            : Add_business(),
        Messages(),
        FullProfile(),
      ];


      
      // FirebaseMessaging.instance
      //     .getInitialMessage()
      //     .then((RemoteMessage message) {
      //   if (message != null) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const ,
      //     );
      //         arguments: MessageArguments(message, true));
      //   }
      // });




      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (message.data['type'] == 'chat') {
          Routes.navigateToScreen(context, Routes.notifi);
        }else{
          (message);
        }
      });




      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,

              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      }
      );

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(notification.title.toString()),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(notification.body.toString())],
                    ),
                  ),
                );
              });
        }
      }

        //@override
        //     void initState(){
        //   FirebaseMessaging.instance.getToken().than(newToken){
        //     print("FCM token"),
        // tokenService.updateTokenOnServer(new token);
        //   }
        // }
      );
    }


    void showNotification() {
      flutterLocalNotificationsPlugin.show(
          0,
          "Testing",
          "How you doing?",
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',

              )
          )
      );
    }

    Widget iconWithText(icon, text, {double fontSize = 10}) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
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
                }),
            items: items),
        body: screens[currentIndex],
      );
    }
  }
