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
import 'package:guilt_app/models/help_support/help_support_master.dart';
import 'package:guilt_app/stores/form/form_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/GlobalStoreHandler.dart';
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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final edNameController = TextEditingController();
  final edEmailController = TextEditingController();
  final edMessageController = TextEditingController();

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
              child: Form(
            key: formkey,
            child: Column(children: [
              AppLogoWidget(
                width: 140.0,
                height: 120.0,
              ),
              Text(
                'Send Us a Message',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                style: TextStyle(fontSize: 13.0, color: Colors.pinkAccent),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur.',
                style: TextStyle(fontSize: 13.0, color: Colors.pinkAccent),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: 330,
                child: TextFormField(
                  controller: edNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: 330,
                child: TextFormField(
                  controller: edEmailController,
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
                  controller: edMessageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Please Enter Message",
                    focusedBorder: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Message";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButtonWidget(
                buttonColor: AppColors.primaryColor,
                buttonText: 'Send',
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    helpAndSupport(edNameController.text,
                        edEmailController.text, edMessageController.text);
                  }
                },
              ),
            ]),
          )),
        ),
      ),
    );
  }

  helpAndSupport(name, email, message) async {
    GlobalStoreHandler.userStore.helpAndSupport(name, email, message,
        (HelpSupportMaster master) {
      if (master != null) {
        if (master.success == true) {
          GlobalMethods.showSuccessMessage(
              context, master.message ?? 'Message sent', 'Help And Support');
          Routes.goBack(context);
        } else {
          GlobalMethods.showErrorMessage(context,
              master.message ?? 'Message sent failed', 'Help And Support');
        }
      }
    }, (error) {
      print(error.toString());
      GlobalMethods.showErrorMessage(context,
          'Something went wrong!', 'Help And Support');
    });
  }
}
