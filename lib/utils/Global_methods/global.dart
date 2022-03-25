// General Methods:-----------------------------------------------------------

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:guilt_app/utils/locale/app_localization.dart';
class GlobalMethods {
  static showErrorMessage(context, String message, String title) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: title,
          duration: Duration(seconds: 3),
        )
          ..show(context);
      }
    });

    return SizedBox.shrink();
  }

}