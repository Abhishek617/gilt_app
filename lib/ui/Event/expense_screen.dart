import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:guilt_app/models/Event/create_event_modal.dart';
import 'package:guilt_app/models/Global/CheckContactResponseModal.dart';
import 'package:guilt_app/models/PageModals/expensemodel.dart';
import 'package:guilt_app/ui/Event/create_event.dart';

import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import '../../constants/colors.dart';
import '../../utils/routes/routes.dart';
import 'package:flutter/rendering.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import '../../widgets/rounded_button_widget.dart';


class Expense_Screen extends StatefulWidget {
  // final List<AppContact> selectedcontactexpenselist;
  // String sdata;
 Expense_Screen({Key? key}) : super(key: key);

  @override
  State<Expense_Screen> createState() => _Expense_ScreenState();
}

class _Expense_ScreenState extends State<Expense_Screen> {
 List<AppContact> selectedcontactexpenselist = [];
  String sdata = '';
  bool viewVisible = false;
  bool status = true;
  final UserStore _userStore = UserStore(getIt<Repository>());
  TextEditingController _amount = TextEditingController();
  bool isChecked = false;

  //bool _value = false;
  int val = -1;
  int _count = 0;

  void _incrementCounter() {
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

  void _decrementCounter() {
    setState(() {
      _count--;
      _amount.text = _count.toString();
    });
  }

  void showWidget() {
    setState(() {
      if (viewVisible = true) {
        viewVisible = true;
      } else {
        viewVisible = false;
      }
    });
  }

  void _showValue() {
    setState(() {});
  }

  createEvent(eData) {
    GlobalMethods.showLoader();
    String dData = jsonDecode(eData);
    _userStore.createEvent(dData as CreateEventRequestModal, (val) {
      GlobalMethods.hideLoader();
      if (val.success == true) {
        GlobalMethods.showSuccessMessage(context, val.message, 'Create Event');
      } else {
        GlobalMethods.showErrorMessage(context, val.message, 'Create Event');
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.data.toString());
    });
  }

  expenseslist(args)
  {
    ExpenseModal elist = ExpenseModal.fromJson(jsonDecode(args));
    Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: viewVisible,
      child: Container(
        height:DeviceUtils.getScaledHeight(context, 0.366),
        child: ListView.builder(
            itemCount: elist.selectedcontactexpenselist?.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                  height: DeviceUtils.getScaledHeight(
                      context, 0.7),
                  width: DeviceUtils.getScaledWidth(
                      context, 0.127),
                  // margin: EdgeInsets.all(100.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.orange,
                      shape: BoxShape.circle),
                ),
                trailing: Wrap(
                  spacing: 7, // space between two icons
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                          child: Icon(
                            Icons.remove,
                            size: 15,
                          )),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: DeviceUtils.getScaledHeight(
                          context, 0.049),
                      width: DeviceUtils.getScaledWidth(
                          context, 0.25),

                      child: TextField(

                        style: TextStyle(fontSize: 11),
                        controller: _amount,
                        keyboardType: TextInputType.number,
                        inputFormatters: <
                            TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,0}')),
                        ],
                        //WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),

                          border: OutlineInputBorder(
                          ),
                          hintText: '',
                        ),

                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                          child: Icon(
                            Icons.add,
                            size: 15,
                          )),
                    )
                  ],
                ),
                title: Text(elist.selectedcontactexpenselist![index].phone.toString() , style:TextStyle(fontSize: 13),),
              );

            }
        ),

      ),
    );
  }


  @override
  Widget build(BuildContext context) {
final args = ModalRoute.of(context)?.settings.arguments;
  print(args);

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
          title: Text('Expense'),
          centerTitle: true,
          shadowColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Add Expense",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _decrementCounter,
                      iconSize: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: DeviceUtils.getScaledHeight(
                          context, 0.07),
                      width: DeviceUtils.getScaledWidth(
                          context, 0.35),
                      child: Center(
                        child: TextField(
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,0}')),
                          ],
                          //WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(),
                            hintText: '\$ 5000',
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
                  height: 10,
                ),
                Container(
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Add Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 40,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Add description',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: viewVisible == false ? ElevatedButtonWidget(
                      buttonText: 'Confirm',
                      buttonColor: AppColors.primaryColor,
                      onPressed: () {

                      }) : disableButton(),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  // color: Colors.teal.shade100,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Add Expense Manually",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(
                          context, 0.43),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: viewVisible == true
                                ? Colors.black
                                : Colors.black,
                            width: 2.3),
                      ),
                      height: 22,
                      width: 22,
                      child: Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        // side: BorderSide(color: Colors.black),
                        tristate: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        value: viewVisible,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              viewVisible = true;
                            } else {
                              viewVisible = false;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    expenseslist(args),
                    SizedBox(
                      height: 5,
                    ),
                    Container(

                      child: viewVisible == true? ElevatedButtonWidget(
                        buttonText: 'Confirm',
                        buttonColor: AppColors.primaryColor,
                        onPressed: () {
                      createEvent(args);
                        },
                      ): disableButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
