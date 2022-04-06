import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  bool viewVisible = true;
  bool status = true;

  TextEditingController _amount = TextEditingController();
  bool isChecked = false;

  //bool _value = false;
  int val = -1;
  int _count = 0;
  void _incrementCounter(){
    setState(() {
      _count++;
      _amount.text = _count.toString();
    });
  }
  disableButton() {
    setState(() {
      status = false;
    });
  }
  enableButton() {
    setState(() {
      status = true;
    });
  }


  void _decrementCounter(){
    setState(() {
      _count--;
      _amount.text = _count.toString();

    });
  }

  void showWidget(){
    setState(() {
      if (viewVisible = true){
        viewVisible = true;
      }else{
        viewVisible = false;
      }

    });
  }



  void _showValue(){
    setState(() {
    });
  }



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
          child: SingleChildScrollView(
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
                      padding: const EdgeInsets.only(left: 53),
                      child: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementCounter,
                        iconSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 45,
                      width: 120,
                      child: Center(
                        child: TextField(
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,0}')),
                                   ],
                            //WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
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
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _incrementCounter,
                      iconSize: 15,
                    ),
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
                      buttonText: 'Confirm',
                      buttonColor: AppColors.primaryColor,
                      onPressed: (){}
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
                    Text("Add Expense Manually",style: TextStyle(
                        fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: 145,
                    ),
                    Container(
                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        border: Border.all(
                            color: viewVisible == true ? Colors.black: Colors.black,
                            width: 2.3),
                      ),
                      height: 21,
                      width: 21,
                      child: Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                     // side: BorderSide(color: Colors.black),
                        tristate: false,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                        value: viewVisible,
                        onChanged: (value) {
                          setState(() {
                          if (value == true){
                            viewVisible = true;
                          }else{
                            viewVisible = false;
                          }
                          }

                          );
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: viewVisible,
                      child: Container(
                        height: 500,
                       // width: 460,
                        width: MediaQuery.of(context).size.width / 0.0,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context,int index){
                              return ListTile(
                                  leading:  Container(
                                    height: 40,
                                    width: 40,
                                    // margin: EdgeInsets.all(100.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage('https://img.icons8.com/color/344/person-male.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        color: Colors.orange,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                  trailing:
                                  Wrap(
                                    spacing: 7, // space between two icons
                                    children: <Widget>[

                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(child: Icon(Icons.remove, size: 15,)),
                                      ),

                                      Container(
                                        height: 30,
                                        width: 50,
                                        child: Center(
                                          child: TextField(
                                            style: TextStyle(fontSize: 10),
                                            controller: _amount,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,0}')),
                                            ],
                                            //WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                              '',
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(child: Icon(Icons.add, size: 15,)),
                                      )
                                    ],
                                  ),
                                  title:Text("Abc $index")
                              );
                            }
                        ),

                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButtonWidget(
                          buttonText: 'Confirm',
                          buttonColor: AppColors.primaryColor,
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),


        )
    );
  }
}


