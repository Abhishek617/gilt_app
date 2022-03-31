import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:guilt_app/constants/colors.dart';

import '../../widgets/custom_scaffold.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _switchValue1 = true;
  bool _switchValue2 = true;
  bool _switchValue3 = true;
  bool _switchValue4 = true;
  bool _switchValue5 = true;
  bool _switchValue6 = true;
  bool _switchValue7 = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Settings'),
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue1,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue1 = Value;
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue2,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue2 = Value;
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue3,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue3 = Value;
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue4,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue4 = Value;
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue5,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue5 = Value;
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue6,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue6 = Value;
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
                      activeToggleColor: AppColors.primaryColour,
                      inactiveToggleColor: Colors.grey,
                      switchBorder: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      activeColor: Colors.white38,
                      inactiveColor: Colors.white38,
                      toggleSize: 18.0,
                      value: _switchValue7,
                      onToggle: (Value) {
                        setState(() {
                          _switchValue7 = Value;
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
