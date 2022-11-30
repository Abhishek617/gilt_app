import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/PageModals/push_sub_settings_modal.dart';
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

class _NotifiSettingsState extends State<NotifiSettings> {

  bool _switch_isEmailNotification = false;
  bool _switch_isPushNotification = false;
  bool _switch_isShowAppIcon = false;
  bool _switch_isFloatingNotification = false;
  bool _switch_isLockScreenNotification = false;
  bool _switch_isAllowSound = false;
  bool _switch_isAllowVibration = false;

  late UserStore _settingStore,_pushSettingStore, _emailSettingStore;
  final UserStore _userStore = UserStore(getIt<Repository>());
  
  List<Settings> arrNotify=[];
  List<Settings> emailarrNotify=[];

  @override
  void didChangeDependencies() {
    if (this.mounted) {
      initSetup();
      getPushSubSetting();
      getemailSubSetting();
      super.didChangeDependencies();
    }
  }


getPushSubSetting() async{
  _pushSettingStore = Provider.of<UserStore>(context);
  await _pushSettingStore.pushsettingGet()
      .then((pushsettingData) {
    // if(pushsettingData.settings != null)
      setState(() {
        arrNotify =pushsettingData.settings;
        print("ArrData: $arrNotify");
        // contentData = PushSettingsModal.fromJson(pushsettingData);
    });
  }).
  catchError((error) => throw error);

}

  getemailSubSetting() async{
    _emailSettingStore = Provider.of<UserStore>(context);
    await _emailSettingStore.emailsettingGet()
        .then((emailsettingData) {
      // if(pushsettingData.settings != null)
      setState(() {
        emailarrNotify =emailsettingData.settings;
        print("ArrData: $emailarrNotify");
        // contentData = PushSettingsModal.fromJson(pushsettingData);
      });
    }).
    catchError((error) => throw error);

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




  pushsublist(Settings data)  => Column(
    children: [
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment. spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
        Text(
          data.label.toString() ?? '',
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
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
          value: data.isReceive!,
          borderRadius: 25.0,
          onToggle: (val) {
            setState(() {
              data.isReceive = val;
            });
          },
        ),
      ],),
    ],
  );


  emailsublist(Settings edata)  => Column(
    children: [
      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment. spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
        Text(
          'Email Notification',
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
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
          value: edata.isReceive!,
          borderRadius: 25.0,
          onToggle: (val) {
            setState(() {
              edata.isReceive = val;
            });
          },
        ),
      ],),
    ],
  );

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

      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Push Notification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
              // _showSwitch==true? showpushsublist():Container(),
              SizedBox(
                height: 15,
              ),
              _switch_isPushNotification == true ?
              ListView.builder(
                shrinkWrap: true,
                  itemCount: arrNotify.length,
                  itemBuilder: (BuildContext context, int index) => Column(children: [
                    pushsublist(arrNotify[index]),

                  ],)): Container(),
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
              Row( mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    'Email Notification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
              SizedBox(
                height: 15,
              ),
              _switch_isEmailNotification == true?
              ListView.builder(



                  shrinkWrap: true,
                  itemCount: emailarrNotify.length,
                  itemBuilder: (BuildContext context, int index) => Column(children: [
                    emailsublist(emailarrNotify[index]),

                  ],)): Container(),
                

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

              Row(
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Show App icon Badges',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Floating Notification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Lock Screen Notification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Allow Sound',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
                mainAxisAlignment: MainAxisAlignment. spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Allow Vibration',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
          ),
        ),
      ),
    );
  }
}