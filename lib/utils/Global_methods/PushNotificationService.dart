import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotificationService {
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;

  PushNotificationService();

  static Future initialise() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    _messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    String? token = await _messaging.getToken();
    print('--------------push notification token------------------');
    print(token);
    GlobalStoreHandler.userStore.saveFcmToken(token);
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // TODO: handle the received notifications
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('On Push Notification...........');
        print(message);
        // Parse the message received
        PushNotificationMessage notification = PushNotificationMessage(
          title: message?.notification?.title,
          body: message?.notification?.body,
        );
        if (notification != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(

            Text(
              notification!.title!,
              style: TextStyle(color: AppColors.primaryColor),
            ),
            subtitle: Text(
              notification!.body!,
              style: TextStyle(color: AppColors.primaryColor),
            ),
            background: AppColors.cream_app,
            duration: Duration(seconds: 3),
            position: NotificationPosition.bottom
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }

    // _fcm.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //       print("onMessage: $message");
    //       if (Platform.isAndroid) {
    //         var notification = PushNotificationMessage(
    //           title: message['notification']['title'],
    //           body: message['notification']['body'],
    //         );
    //         showSimpleNotification(
    //           Container(child: Text(notification.body)),
    //           position: NotificationPosition.top,
    //         );
    //
    //       }
    //       // show notification UI here
    //     },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
  }
}

class PushNotificationMessage {
  final String? title;
  final String? body;

  PushNotificationMessage({
    required this.title,
    required this.body,
  });
}
