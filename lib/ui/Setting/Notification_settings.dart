import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/PageModals/setting_model.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';

import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class NotifiSettings extends StatefulWidget {
  const NotifiSettings({Key? key}) : super(key: key);

  @override
  State<NotifiSettings> createState() => _NotifiSettingsState();
}

// bool showappicon = false;
// bool floatingnotifi = false;
// bool lockscreennotifi = false;
// bool allowsound = false;
// bool allowvibration = false;
// bool estatus = false;
// bool status = false;
bool notifi1 = true;
bool notifi2 = true;
bool notifi3 = true;
bool notifi4 = true;
bool notifi5 = true;
bool notifi6 = true;
bool notifi7 = true;
bool notifi8 = true;
bool notifi9 = true;
bool notifi10 = true;
bool notifi11 = true;
bool notifi12 = true;
bool notifi13 = true;
bool notifi14 = true;
bool notifi15 = true;
bool notifi16 = true;
bool notifi17 = true;
bool notifi18 = true;
bool notifi19 = true;
bool notifi20 = true;

class _NotifiSettingsState extends State<NotifiSettings> {
  bool _switch_isEmailNotification = false;
  bool _switch_isPushNotification = false;
  bool _switch_isShowAppIcon = false;
  bool _switch_isFloatingNotification = false;
  bool _switch_isLockScreenNotification = false;
  bool _switch_isAllowSound = false;
  bool _switch_isAllowVibration = false;
  late UserStore _settingStore;
  final UserStore _userStore = UserStore(getIt<Repository>());
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initSetup();
  }

  initSetup() async {
    // initializing stores
    _settingStore = Provider.of<UserStore>(context);
    await _settingStore.settingGet()
        .then((settingData) {
      if(settingData.adminSettings.notification == null)
        setState(() {
          var setingnotification = settingData.adminSettings.notification;
          _switch_isEmailNotification =
              setingnotification.isEmailNotification == 1;
          _switch_isPushNotification = setingnotification.isPushNotification == 1;
          _switch_isShowAppIcon = setingnotification.isShowAppIcon == 1;
          _switch_isFloatingNotification =
              setingnotification.isFloatingNotification == 1;
          _switch_isLockScreenNotification =
              setingnotification.isLockScreenNotification == 1;
          _switch_isAllowSound = setingnotification.isAllowSound == 1;
          _switch_isAllowVibration = setingnotification.isAllowVibration == 1;
        });
    }).catchError((error) => throw error);
  }
  updatedata() {
    final SettingData = SettingPostModal.fromJson({
      "is_push_notification": _switch_isPushNotification ? 1 : 0,
      "is_email_notification": _switch_isEmailNotification ? 1 : 0,
      "is_show_app_icon": _switch_isShowAppIcon ? 1 : 0,
      "is_floating_notification": _switch_isFloatingNotification ? 1 : 0,
      "is_lock_screen_notification": _switch_isLockScreenNotification ? 1 : 0,
      "is_allow_sound": _switch_isAllowSound ? 1 : 0,
      "is_allow_vibration": _switch_isAllowVibration ? 1 : 0,
    });
    _userStore.settingpost(SettingData, (val) {
      print(val);
      (val.success == true)
          ? (val.user != null)
          ? Routes.navigateToScreenWithArgs(
          context,
          Routes.success_error_validate,
          SuccessErrorValidationPageArgs(
              isSuccess: true,
              description: 'SignUp Success',
              title: 'Success',
              isPreviousLogin: true))
          : Routes.navigateRootToScreen(context, Routes.otpvalidate)
          : GlobalMethods.showErrorMessage(
          context, val.message, 'Update Profile');
    }, (error) {
      print(error.data.toString());
      final data =
      json.decode(json.encode(error.data)) as Map<String, dynamic>;
      print(data['error']);
      // Map<String, dynamic> map = json.decode(error.data);
      List<dynamic> dataList = data["error"];
      print(dataList[0]["message"]);
      GlobalMethods.showErrorMessage(
          context,
          dataList[0]["field"] + ' : ' + dataList[0]["message"],
          'Sign Up Exception');
    });
  }

    subpushnotifi() =>
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Event Update Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi1,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi1 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Event Cancel Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi2,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi2 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Event Invitation Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi3,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi3 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(

                  'New Message Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi4,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi4 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(

                  'Upcoming Event Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi5,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi5 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(

                  'Event Payment Receiving notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi6,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi6 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Business Payment Receiving notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi7,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi7 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment. spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Payment Receiving from user notification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi8,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi8 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
        
            Divider(
              color: Colors.black12,
              //color of divider
              height: 20,
              //height spacing of divider
              thickness: 1,
              //thickness of divider line
              indent: 0,
              //spacing at the start of divider
              endIndent: 0, //spacing at the end of divider
            ),
          ],
        );

    subemailnotifi() =>
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi11,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi11 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi12,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi12 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi13,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi13 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi14,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi14 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi15,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi15 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi16,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi16 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi17,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi17 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi18,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi18 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi19,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi19 = val;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 168,
                ),
                FlutterSwitch(
                  activeToggleColor: AppColors.primaryColor,
                  inactiveToggleColor: Colors.grey,
                  activeColor: Colors.white38,
                  inactiveColor: Colors.white38,
                  switchBorder: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  width: 40.0,
                  height: 22.0,
                  toggleSize: 14.0,
                  value: notifi20,
                  borderRadius: 25.0,
                  onToggle: (val) {
                    setState(() {
                      notifi20 = val;
                    });
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.black12,
              //color of divider
              height: 20,
              //height spacing of divider
              thickness: 1,
              //thickness of divider line
              indent: 0,
              //spacing at the start of divider
              endIndent: 0, //spacing at the end of divider
            ),
          ],
        );

    blankcont() =>
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black12,
              //color of divider
              height: 20,
              //height spacing of divider
              thickness: 1,
              //thickness of divider line
              indent: 0,
              //spacing at the start of divider
              endIndent: 0, //spacing at the end of divider
            ),
          ],
        );

    showpushsublist() => _switch_isPushNotification == true ? subpushnotifi() : blankcont();

    showemailsublist() => _switch_isEmailNotification == true ? subpushnotifi() : blankcont();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Routes.goBack(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            //color: Colors.black,
            size: 15,
          ),
        ),
        title: Text('Settings'),
        shadowColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Push Notification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 136,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isPushNotification,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isPushNotification = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
                showpushsublist(),
                Row(
                  children: [
                    Text(
                      'Email Notification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 132,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isEmailNotification,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isEmailNotification = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
                showemailsublist(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Show App icon Badges',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 96,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isShowAppIcon,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isShowAppIcon = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Floating Notification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 114,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isFloatingNotification,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isFloatingNotification = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Lock Screen Notification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 84,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isLockScreenNotification,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isLockScreenNotification = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Allow Sound',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isAllowSound,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isAllowSound = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(

                  children: [
                    Text(
                      'Allow Vibration',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 151,
                    ),
                    FlutterSwitch(
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      width: 50.0,
                      height: 27.0,
                      toggleSize: 18.0,
                      value: _switch_isAllowVibration,
                      borderRadius: 30.0,
                      onToggle: (val) {
                        setState(() {
                          _switch_isAllowVibration = val;
                          updatedata();
                        });
                      },
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
