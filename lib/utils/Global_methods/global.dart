// General Methods:-----------------------------------------------------------

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/utils/locale/app_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalMethods {
  static showErrorMessage(context, String message, String title) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: title,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }

  static showSuccessMessage(context, String message, String title) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: title,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  static Future<void> askPermissions(context, String routeName) async {
    PermissionStatus permission = await Permission.contacts.status;
    PermissionStatus permissionStatus = await getPermission(permission);
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      handleInvalidPermissions(context, permissionStatus);
    }
  }

  static Future<void> askPermissionsOnly(context, callback) async {
    PermissionStatus permission = await Permission.contacts.status;
    PermissionStatus permissionStatus = await getPermission(permission);
    if (permissionStatus == PermissionStatus.granted) {
      callback();
    } else {
      handleInvalidPermissions(context, permissionStatus);
    }
  }

  static Future<void> askLocationPermissionsOnly(context, callback) async {
    PermissionStatus permission = await Permission.location.status;
    PermissionStatus permissionStatus = await getPermission(permission);
    if (permissionStatus == PermissionStatus.granted) {
      callback();
    } else {
      handleInvalidPermissions(context, permissionStatus);
    }
  }

  static Future<PermissionStatus> getPermission(permission) async {
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  static void handleInvalidPermissions(
      context, PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Permission is denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Permission is permanently denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 30.0
      ..radius = 10.0
      ..progressColor = AppColors.primaryColor
      ..backgroundColor = AppColors.cream_app
      ..indicatorColor = AppColors.primaryColor
      ..textColor = AppColors.primaryColor
      ..maskColor = Colors.grey.withOpacity(0.3)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static showLoader() async {
    await configLoading();
    await EasyLoading.show(
        status: 'Loading',
        maskType: EasyLoadingMaskType.custom,
        dismissOnTap: false);

    Future.delayed(Duration(milliseconds: 3000)).then((value) => hideLoader());
  }

  static hideLoader() async {
    await EasyLoading.dismiss();
  }

  static hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }

  static launchCaller(String mobileNumber) async {
    Uri uri = Uri.parse("tel:$mobileNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
