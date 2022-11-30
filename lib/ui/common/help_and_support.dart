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
class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
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
          title: Text('Help & Support'),
          centerTitle: true,
          shadowColor: Colors.transparent,
        ),
        child: SingleChildScrollView(
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
                    'Send Us a Message',
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
                      fontSize: 13.0,color: Colors.pinkAccent
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur.',
                    style: TextStyle(
                        fontSize: 13.0,color: Colors.pinkAccent
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: 330,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Enter Name',
                      ),

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: 330,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                        labelText: 'Enter Email',
                      ),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)) {
                          return "Enter a Valid Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(

                    // height: 50,
                    width: 330,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(

                        hintText: "Please Enter Message",
                        focusedBorder: OutlineInputBorder(),

                      ),

                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButtonWidget(
                    buttonColor: AppColors.primaryColor,
                    buttonText: 'Send',
                    onPressed: ()async {
                      Routes.navigateToScreen(context, Routes.message);
                    },
                  ),
                ]
              )

          ),
        ),
        ),
    );
  }
}
