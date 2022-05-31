import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:guilt_app/models/Event/CreateEventResponseModel.dart';
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
  // final List<AppContact> attendees;
  // String sdata;
  Expense_Screen({Key? key}) : super(key: key);

  @override
  State<Expense_Screen> createState() => _Expense_ScreenState();
}

class _Expense_ScreenState extends State<Expense_Screen> {
  List<AppContact> attendees = [];
  String sdata = '';
  bool viewVisible = false;
  bool status = true;
  final UserStore _userStore = UserStore(getIt<Repository>());
  TextEditingController _amount = TextEditingController(text: 0.toString());
  TextEditingController _expensedescription = TextEditingController();
  bool isChecked = false;
  var myControllers = [];
  int _count = 0;
  var createEventDetails;
  var expensedata;
  var addexpensedata;

  createControllers(elist) {
    for (var i = 0; i < elist.attendees.length; i++) {
      myControllers.add(TextEditingController(text: 0.toString()));
    }
  }

  void _incrementCounter(amount) {
    setState(() {
      int ival = int.parse(amount.text);
      addexpensedata = ival;
      addexpensedata = addexpensedata + 1;
      amount.text = addexpensedata.toString();
      //changeTotalExpanse();
      // _count++;
      // _amount.text = _count.toString();
    });
  }

  void _incrementCounterelist(expensecontroller) {
    setState(() {
      int currentval = int.parse(expensecontroller.text);
      expensedata = currentval;
      expensedata = expensedata + 1;
      expensecontroller.text = expensedata.toString();
      changeTotalExpanse();
    });
  }

  void _decrementCounterelist(expensecontroller) {
    setState(() {
      int currentvald = int.parse(expensecontroller.text);
      expensedata = currentvald;
      if (expensedata > 0) {
        expensedata = expensedata - 1;
        expensecontroller.text = expensedata.toString();
      }
      changeTotalExpanse();
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

  void _decrementCounter(amount) {
    setState(() {
      int dval = int.parse(amount.text);
      addexpensedata = dval;
      if (addexpensedata > 0) {
        addexpensedata = addexpensedata - 1;
        amount.text = addexpensedata.toString();
      }
      //changeTotalExpanse();
      // _count--;
      // _amount.text = _count.toString();
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

  createEvent(CreateEventRequestModal eData) async {
    print('createEvent RequestData :');
    //print(eData);
    GlobalMethods.showLoader();
    _userStore.createEvent(eData, (CreateEventResponseModel val) {
      GlobalMethods.hideLoader();
      if (val.success == true) {
        GlobalMethods.showSuccessMessage(
            context, val.message ?? 'Success', 'Create Event');
        if (val.data != null) {
          Routes.navigateToScreenWithArgs(
              context, Routes.event_details, val.data?.id);
        }
      } else {
        GlobalMethods.showErrorMessage(
            context, val.message ?? 'Failed', 'Create Event');
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.data.toString());
    });
  }

  changeTotalExpanse() {
    var totalExp = 0;
    myControllers.forEach((cntrl) {
      totalExp = totalExp + int.parse(cntrl.value.text);
    });
    setState(() {
      print('totalExp : ');
      print(totalExp.toString());
      _amount.text = totalExp.toString();
    });
  }

  expenseslist(args) {
    CreateEventRequestModal elist = args;
    createControllers(elist);
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: viewVisible,
      child: Container(
        height: DeviceUtils.getScaledHeight(context, 0.366),
        child: ListView.builder(
            itemCount: elist.attendees?.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Container(
                  height: DeviceUtils.getScaledHeight(context, 0.7),
                  width: DeviceUtils.getScaledWidth(context, 0.127),
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
                  crossAxisAlignment: WrapCrossAlignment.center,
                  // space between two icons
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              _decrementCounterelist(myControllers[index]);
                            });
                          },
                          iconSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: DeviceUtils.getScaledHeight(context, 0.030),
                      width: DeviceUtils.getScaledWidth(context, 0.17),
                      child: TextFormField(
                        style: TextStyle(fontSize: 11),
                        controller: myControllers[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,0}')),
                        ],
                        //WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          border: OutlineInputBorder(),
                          hintText: '',
                        ),
                        onChanged: (value) {
                          changeTotalExpanse();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              _incrementCounterelist(myControllers[index]);
                            });
                          },
                          iconSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
                title: Text(
                  elist.attendees![index].phone.toString(),
                  style: TextStyle(fontSize: 9),
                ),
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as CreateEventRequestModal;
    print(args);
    print(expensedata);
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
                      onPressed: () {
                        _decrementCounter(_amount);
                      },
                      iconSize: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: DeviceUtils.getScaledHeight(context, 0.07),
                      width: DeviceUtils.getScaledWidth(context, 0.35),
                      child: Center(
                        child: TextFormField(
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
                            hintText: '500',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _incrementCounter(_amount);
                        },
                        iconSize: 15),
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
                      controller: _expensedescription,
                      minLines: 2,
                      maxLines: 40,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Add description',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (String) {
                        print(_expensedescription.value.text);
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: viewVisible == false
                      ? ElevatedButtonWidget(
                          buttonText: 'Confirm',
                          buttonColor: AppColors.primaryColor,
                          onPressed: () {
                            if (_amount.value.text.trim() != '0' &&
                                _amount.value.text.trim() != '') {
                              if (_expensedescription.value.text.trim() != '') {
                                final expenseData = CreateEventRequestModal(
                                  name: args!.name,
                                  category: args!.category,
                                  location: args!.location,
                                  startDate: args!.startDate,
                                  description: args!.description,
                                  expenseDescription:
                                      _expensedescription.value.text,
                                  totalExpense: _amount.value.text,
                                  attendees: args.attendees,
                                  lat: args.lat,
                                  endDate: args!.endDate,
                                  long: args.long,
                                  files: args!.files,
                                );
                                createEvent(expenseData);
                              } else {
                                GlobalMethods.showErrorMessage(
                                    context,
                                    'Please add expense description',
                                    'Description required');
                              }
                            } else {
                              GlobalMethods.showErrorMessage(context,
                                  'Please add expense', 'Expense required');
                            }
                          })
                      : disableButton(),
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
                      width: DeviceUtils.getScaledWidth(context, 0.43),
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
                      child: viewVisible == true
                          ? ElevatedButtonWidget(
                              buttonText: 'Confirm',
                              buttonColor: AppColors.primaryColor,
                              onPressed: () {
                                for (int i = 0; i < myControllers.length; i++) {
                                  args.attendees.forEach((element) {
                                    element.expanse =
                                        double.parse(myControllers[i].text);
                                  });
                                }
                                final expenseData = CreateEventRequestModal(
                                  name: args!.name,
                                  category: args!.category,
                                  location: args!.location,
                                  startDate: args!.startDate,
                                  description: args!.description,
                                  expenseDescription:
                                      _expensedescription.value.text,
                                  totalExpense: _amount.value.text,
                                  attendees: args.attendees,
                                  lat: '',
                                  endDate: args!.endDate,
                                  long: '',
                                  files: args!.files,
                                );
                                createEvent(expenseData);
                              },
                            )
                          : disableButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
