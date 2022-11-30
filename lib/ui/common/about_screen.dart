import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/constants/dimens.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/models/about/about_master.dart';
import 'package:guilt_app/stores/form/form_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/rounded_button_widget.dart';

class About_screen extends StatefulWidget {
  const About_screen({Key? key}) : super(key: key);

  @override
  State<About_screen> createState() => _About_screenState();
}

class _About_screenState extends State<About_screen> {
  late UserStore _postStore;
  AboutMaster? aboutAppData;
  AppDetails? appDetails;

  @override
  void initState() {
    _postStore = Provider.of<UserStore>(context, listen: false);
    super.initState();
    Future.delayed(Duration.zero, () {
      _postStore.getAppContent('app_version').then((value) {
        setState(() {
          aboutAppData = AboutMaster.fromJson(value);
          if (aboutAppData != null && aboutAppData!.data != null && aboutAppData!.data!.about != null) {
            if (Platform.isIOS) {
              appDetails = aboutAppData!.data!.about!.ios;
            } else {
              appDetails = aboutAppData!.data!.about!.android;
            }
          }
        });
        GlobalMethods.hideLoader();
      }).catchError((error) {
        print(error.toString());
        GlobalMethods.hideLoader();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _postStore = Provider.of<UserStore>(context);
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
            size: 13,
          ),
        ),
        title: Text('About'),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      child: appDetails != null
          ? Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                  child: Column(
                children: [
                  AppLogoWidget(
                    width: 140.0,
                    height: 120.0,
                  ),
                  Text(
                    'Gult Trip',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${appDetails!.feature}',
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${appDetails!.msg}',
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Developed By',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${appDetails!.developedBy}',
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Version Info',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${appDetails!.version}',
                    style: TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Follow Us On',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://img.icons8.com/ios/344/facebook-new.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://img.icons8.com/ios/344/twitter-circled--v1.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/128/1362/1362857.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 40,
                        width: 35,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://img.icons8.com/ios/344/youtube-play--v1.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            )
          : Container(),
    );
  }
}
