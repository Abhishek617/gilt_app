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
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text('     About'),
        ),
        shadowColor: Colors.transparent,
      ),
      child: Padding(
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
                        fontSize: 16.0,fontWeight: FontWeight.bold, color: Colors.pinkAccent
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                    style: TextStyle(
                        fontSize: 13.0,color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur.',
                    style: TextStyle(
                        fontSize: 13.0,color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Developed By',
                    style: TextStyle(
                        fontSize: 14.0,fontWeight: FontWeight.bold, color: Colors.black
                    ),
                  ),

          SizedBox(
            height: 8,
          ),
          Text(
            'Abc.',
            style: TextStyle(
                fontSize: 12.0,color: Colors.black
            ),
          ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Version Info',
                    style: TextStyle(
                        fontSize: 14.0,fontWeight: FontWeight.bold, color: Colors.black
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Android version 5.0 to 5.1.1: Lollipop',
                    style: TextStyle(
                        fontSize: 12.0,color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Follow Us On',
                    style: TextStyle(
                        fontSize: 14.0,fontWeight: FontWeight.bold, color: Colors.black
                    ),
                  ),

                  SizedBox(

                    height: 30,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 100,
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
                            image: NetworkImage('https://img.icons8.com/ios/344/facebook-new.png'),
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
                            image: NetworkImage('https://img.icons8.com/ios/344/twitter-circled--v1.png'),
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
                            image: NetworkImage('https://cdn-icons-png.flaticon.com/128/1362/1362857.png'),
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
                            image: NetworkImage('https://img.icons8.com/ios/344/youtube-play--v1.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),


                    ],
                  ),



                ],
            )

        ),
      ),
    );
  }
}
