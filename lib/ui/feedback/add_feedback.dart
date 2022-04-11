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
  //bool isSelected = true;
  bool good = false;
  bool verygood = false;
  bool excellent = false;

  bool _value = false;
  int val = -1;
  Color _iconColor = Colors.red;

  //BestTutorSite _site = BestTutorSite.javatpoint;

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

                              good = true;
                              excellent = false;
                              verygood = false;
                            });
                          },
                        ),


                        SizedBox(
                          width: 5,
                        ),
                        Text('Good'),
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

                                good = false;
                                excellent = true;
                                verygood = false;
                              });
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Very Good'),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: ElevatedButtonWidget(
                      buttonText: 'Submit',
                      buttonColor: AppColors.primaryColor,
                      onPressed: () {
                        


                        Routes.navigateToScreen(context, Routes.feedback_list);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
class Item {
  String name;
  String title;
  String url;

  Item({required this.url, required this.name, required this.title});
}



