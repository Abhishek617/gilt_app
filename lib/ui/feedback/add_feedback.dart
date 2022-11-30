import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import '../../constants/colors.dart';
import '../../utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/PageModals/success_error_args.dart';
import 'package:guilt_app/stores/form/form_store.dart';
import 'package:guilt_app/stores/theme/theme_store.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/app_logo.dart';
import 'package:guilt_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../widgets/rounded_button_widget.dart';

class Add_feedback extends StatefulWidget {
  const Add_feedback({Key? key}) : super(key: key);

  @override
  State<Add_feedback> createState() => _Add_feedbackState();
}

class _Add_feedbackState extends State<Add_feedback> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _DescripationController = TextEditingController();
  ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  late UserStore _feedbackStore;

  String? rate;

  void selectRate(value) {
    setState(() {
      rate = value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _feedbackStore = Provider.of<UserStore>(context);

    // check to see if already called api
  }

  //bool isSelected = true;
  bool good = true;
  bool verygood = false;
  bool excellent = false;

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
          title: Text('Add Feedback'),
          shadowColor: Colors.transparent,
        ),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          '1. How would you rate your check in experience today?',
                          maxLines: 4,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      //  height: DeviceUtils.getScaledHeight(context, 0.10),
                      //width: 90,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            child: Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    child: Image.network(
                                      good
                                          ? 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/48/slightly-smiling-face_1f642.png'
                                          : 'https://spng.subpng.com/20180802/vcc/kisspng-black-white-emoticon-smiley-computer-icons-clip-smile-svg-png-icon-free-download-505342-onlin-5b62bb3990c076.4970999815331971135929.jpg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectRate(rate);
                                good = true;
                                excellent = false;
                                verygood = false;
                              });
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Good"),
                          SizedBox(
                            width: 20,
                          ),
                          Row(children: [
                            GestureDetector(
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        excellent
                                            ? 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/facebook/158/slightly-smiling-face_1f642.png'
                                            : 'https://www.pinclipart.com/picdir/middle/1-13209_banner-download-black-and-white-emoji-clipart-smile.png',
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectRate(rate);
                                  good = false;
                                  excellent = true;
                                  verygood = false;
                                });
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Very Good"),
                          ]),
                          SizedBox(
                            width: 20,
                          ),
                          Row(children: [
                            GestureDetector(
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        verygood
                                            ? 'https://cdn.pixabay.com/photo/2020/12/27/20/24/smile-5865208_1280.png'
                                            : 'https://www.seekpng.com/png/detail/156-1565014_squinty-smiling-face-emoji-rubber-stamp-black-and.png',
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectRate(rate);
                                  good = false;
                                  excellent = false;
                                  verygood = true;
                                });
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Excellent'),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      width: 25,
                    ),
                    TextFormField(
                      controller: _DescripationController,
                      minLines: 2,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'description...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) return "Enter description.";
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: ElevatedButtonWidget(
                        buttonText: 'Submit',
                        buttonColor: AppColors.primaryColor,
                        onPressed: () {
                          {
                            if (formkey.currentState!.validate()) {
                              _userStore.Feedback_add(
                                  _DescripationController.value.text,
                                  27,
                                  getRating(), (value) {
                                Routes.navigateRootToScreen(
                                    context, Routes.feedback_list);
                                // Routes.navigateToScreenWithArgs(
                                //     context,
                                //     Routes.success_error_validate,
                                //     SuccessErrorValidationPageArgs(
                                //         isSuccess: true,
                                //         description: 'Logged in successfully',
                                //         title: 'Success',
                                //         isPreviousLogin: false));
                              }, (error) {
                                print(error);
                                final data =
                                    json.decode(json.encode(error.data));
                                // Map<String, dynamic> map = json.decode(error.data);
                                GlobalMethods.showErrorMessage(context,
                                    data['error'], 'Enter Discripation');
                              }).then((value) {
                                print(value);
                              });
                            }

                            //Routes.navigateToScreenWithArgs(context, Routes.success_error_validate,SuccessErrorValidationPageArgs(isSuccess: true, description: 'Logged in successfully', title: 'Success', isPreviousLogin: true));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  String getRating() {
    String rating = "";
    if (good)
      rating = "good";
    else if (verygood)
      rating = "verygood";
    else if (excellent) rating = "excellent";
    return rating;
  }
}

class Item {
  String name;
  String title;
  String url;

  Item({required this.url, required this.name, required this.title});
}
