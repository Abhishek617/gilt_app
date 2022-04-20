import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/PageModals/setting_model.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _switch_isEmailNotification = true;
  bool _switch_isPushNotification = true;
  bool _switch_isShowAppIcon = true;
  bool _switch_isFloatingNotification = true;
  bool _switch_isLockScreenNotification = true;
  bool _switch_isAllowSound = true;
  bool _switch_isAllowVibration = true;
  late UserStore _settingStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initSetup();
  }

  initSetup() async {
    // initializing stores
    _settingStore = Provider.of<UserStore>(context);
    await _settingStore.settingGet().then((settingData) {
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

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Settings'),
        centerTitle: true,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 25,
            ),
            child: Row(
              children: [
                Text(
                  'Setting & Notifications',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Row(
              children: [
                Text(
                  'Push Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 142,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isPushNotification,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isPushNotification = Value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 5),
            child: Row(
              children: [
                Text(
                  'I Would not miss it for the world. But if something \n else came up I would definitely not go.',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Row(
              children: [
                Text(
                  'Email Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 139,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isEmailNotification,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isEmailNotification = Value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 10),
            child: Row(
              children: [
                Text(
                  'I Would not miss it for the world. But if something \n else came up I would definitely not go.',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black12,
            //color of divider
            height: 20,
            //height spacing of divider
            thickness: 1,
            //thickness of divier line
            indent: 20,
            //spacing at the start of divider
            endIndent: 20, //spacing at the end of divider
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Row(
              children: [
                Text(
                  'Show App icon Badges',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 107,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isShowAppIcon,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isShowAppIcon = Value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Row(
              children: [
                Text(
                  'Floating Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 122,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isFloatingNotification,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isFloatingNotification = Value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Row(
              children: [
                Text(
                  'Lock Screen Notification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 97,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isLockScreenNotification,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isLockScreenNotification = Value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Row(
              children: [
                Text(
                  'Allow Sound',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 172,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isAllowSound,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isAllowSound = Value;
                        });
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Row(
              children: [
                Text(
                  'Allow Vibration',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 155,
                  ),
                  child: FlutterSwitch(
                      width: 50.0,
                      height: 27.0,
                      valueFontSize: 25.0,
                      borderRadius: 30.0,
                      activeToggleColor: AppColors.primaryColor,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switch_isAllowVibration,
                      onToggle: (Value) {
                        setState(() {
                          _switch_isAllowVibration = Value;
                        });
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
