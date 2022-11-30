import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '';


class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _card_number = TextEditingController();
  TextEditingController _ccv = TextEditingController();
  TextEditingController _date = TextEditingController();
  //var _controller = new MaskedTextController(mask: '00/00');
  //var _controller = new TextEditingController(text: donation.date);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Routes.navigateToScreen(
                context, Routes.explore_home);

          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            //color: Colors.black,
            size: 15,
          ),
        ),
        title: Text('Card'),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Details of Card',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text('Full name on the card' ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                       // labelText: 'Password',
                      ),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r"^[a-zA-Z]+")
                                .hasMatch(val)) {
                          return "Enter a Valid Name";
                        } else {
                          return null;
                        }
                      },

                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Credit card number'),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _card_number,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r"^[0-9]+")
                                .hasMatch(val)) {
                          return "Enter a Valid Number";
                        } else {
                          return null;
                        }
                      },

                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Expire Date ', ),
                        SizedBox(
                          width: 100,
                        ),
                        Text("CCV")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          //height: 50,
                          width: DeviceUtils.getScaledWidth(context, 0.43),
                          child:TextFormField(
                            maxLength:5,
                              controller: _date, //<-- Add controller here
                              onChanged: (value) {
                                if(value.length == 2) _date.text += "/"; //<-- Automatically show a '/' after dd
                               var donation;
                               donation.date = value;
                                var _controller = new TextEditingController(text: donation.date);
                              },
                            // validator: (val) {
                            //   if (val!.isEmpty ||
                            //       !RegExp(r"^[0-9]+")
                            //           .hasMatch(val)) {
                            //     return "Enter a Valid CCV";
                            //   } else {
                            //     return null;
                            //   }
                            // },

                          ),

                        ),


                        SizedBox(
                          width: 3,
                        ),




                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          // height: 50,
                          width: DeviceUtils.getScaledWidth(context, 0.43),
                          child: TextFormField(
                            maxLength:3,
                            controller: _ccv,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: (val) {
                              if (val!.isEmpty ||
                                  !RegExp(r"^[0-9]+")
                                      .hasMatch(val)) {
                                return "Enter a Valid CCV";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: ElevatedButtonWidget(
                        buttonText: 'Confirm',
                        buttonColor: AppColors.primaryColor,
                        onPressed: () {}
                      ),
                    ),


                  ],
                ),
              ),
            )

        ),
      ),
    );
  }
}
