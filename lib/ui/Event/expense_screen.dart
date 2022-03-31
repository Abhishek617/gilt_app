import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guilt_app/models/PageModals/faqs_model.dart';
import 'package:flutter/material.dart';
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


class Expense_Screen extends StatefulWidget {
  const Expense_Screen({Key? key}) : super(key: key);

  @override
  State<Expense_Screen> createState() => _Expense_ScreenState();
}

class _Expense_ScreenState extends State<Expense_Screen> {
  bool _value = false;
  int val = -1;
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
          title: Text('               Expense'),
          shadowColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("Add Expense",style: TextStyle(
                    fontWeight: FontWeight.bold),),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 85),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 15, ),
                        height: 10,
                        child: Icon(Icons.minimize, size: 17,)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 120,

                    child: Center(

                      child: TextField(

                        textAlign: TextAlign.center,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(),
                          hintText:
                              '\$ 5000',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.add, size: 15,),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              Container(
                height: 10,
                width: 130,
                color: Colors.grey,
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  child: Divider(
                    // color: Colors.teal.shade100,
                    thickness: 1.0,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Text("Add Description",style: TextStyle(
                      fontWeight: FontWeight.bold),),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: 340,
                child: TextFormField(
                  minLines: 2,
                  maxLines: 40,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Add description',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButtonWidget(
                    buttonText: 'Conform',
                    buttonColor: AppColors.primaryColour,
                    onPressed: () {
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  child: Divider(
                    // color: Colors.teal.shade100,
                    thickness: 1.0,
                  ),
                ),
              ),

              Row(
                children: [
                  Text("Add Expense",style: TextStyle(
                      fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 210),
                    child: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = val;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}


