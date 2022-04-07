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

class Bank_lists extends StatefulWidget {
  const Bank_lists({Key? key}) : super(key: key);

  @override
  State<Bank_lists> createState() => _Bank_listsState();
}

class _Bank_listsState extends State<Bank_lists> {


  //bool viewVisible = false;
  //bool status = true;


  //static int _len = 8;
  //bool _isChecked = false;
  //List<bool> _isChecked = [] ;


  //bool checked = true;
  //String _title = "Checkbox Demo";
  //String _getTitle() =>"Checkbox : Checked = ${isChecked.where((check) => check == true).length}, ""Unchecked = ${isChecked.where((check) => check == false).length}";

  //bool isChecked =  true;
  //bool checked = true;


  //void showWidget(){
 //   setState(() {
   //   if (viewVisible = true){
     //   viewVisible = true;
    //  }else{
    //    viewVisible = false;
   //   }

   // });
 // }
  List<String> _texts = [
    "Bank Account",
    "Credit Card",
    "Debit Card",
    "Crypto Wallet",
    "Apple Pay",
    "Android Pay",
    "Google Pay",
    "Paypal"
  ];

  bool _customTileExpanded = false;
  bool _customTileExpanded1 = false;
  bool _customTileExpanded2 = false;
  bool _customTileExpanded3 = false;
  bool _customTileExpanded4 = false;
  bool _customTileExpanded5 = false;
  bool _customTileExpanded6 = false;
  bool _customTileExpanded7 = false;



  //late List<bool> _isChecked;




  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(

      appBar: AppBar(
        actions: [
        Text('  Skip   ',style: TextStyle(color: Colors.white),)
        ],
       backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        //: Text('Skip'),
      ),
      child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: AppLogoWidget(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height:  DeviceUtils.getScaledWidth(context, 0.10),

            ),
          ),

          ExpansionTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/pay.png'),
                    fit: BoxFit.fitWidth
                ),
              ),
            ),

              title: const Text('Bank Account'),
          //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
             Row(
               children: [
                 Text("         Credit on Card")],
             ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
               // height: DeviceUtils.getScaledHeight(context, 0.06),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    '   Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text('CCV', style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),

                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
          ExpansionTile(
            leading: Container(
              height: DeviceUtils.getScaledWidth(context, 0.10),
              width: DeviceUtils.getScaledWidth(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'),
                  fit: BoxFit.fill,

                ),
              ),
            ),
            title: const Text('Credit Card'),
            //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded1
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
              Row(
                children: [Text("         Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: 330,
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

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
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Valid Last Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded1 = expanded);

            },
          ),
          ExpansionTile(
            leading: Container(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height: DeviceUtils.getScaledHeight(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'),
                  fit: BoxFit.fill,

                ),),
              ),
            title: const Text('Debit Card'),
            trailing: Icon(
              _customTileExpanded2
                  ? Icons.check_circle_sharp
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
              Row(
                children: [Text("         Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.10),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: 162,
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),

                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded2 = expanded);
            },
          ),
          ExpansionTile(
            leading: Container(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height: DeviceUtils.getScaledHeight(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'), fit: BoxFit.fill,

                ),
              ),
              ),
            title: const Text('Crypto Wallet'),
            //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded3
                  ? Icons.check_circle_sharp
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[

              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text("Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),

                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);

                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded3 = expanded);
            },
          ),


          ExpansionTile(
            leading: Container(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height: DeviceUtils.getScaledHeight(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'),

                ),
              ),
              ),

              title: const Text('Apply Pay'),
            //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded4
                  ? Icons.check_circle_sharp
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
              Row(
                children: [Text("         Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter valid First Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Valid Last Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded4 = expanded);
            },
          ),
          ExpansionTile(
            leading:Container(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height: DeviceUtils.getScaledHeight(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'), fit: BoxFit.fill,
                ),
                ),
              ),

              title: const Text('Android Pay'),
            //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded5
                  ? Icons.check_circle_sharp
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
              Row(
                children: [Text("         Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

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
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: 162,
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),

                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded5 = expanded);
            },
          ),
          ExpansionTile(
            leading: Container(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height: DeviceUtils.getScaledHeight(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'), fit: BoxFit.fill,

                ),
              ),
              ),
            title: const Text('Google Pay'),
            //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded7
                  ? Icons.check_circle_sharp
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
              Row(
                children: [Text("         Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter valid First Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),

                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded7 = expanded);
            },
          ),
          ExpansionTile(
            leading: Container(
              width: DeviceUtils.getScaledWidth(context, 0.10),
              height: DeviceUtils.getScaledHeight(context, 0.10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/pay.png'), fit: BoxFit.fill,
                ),
              ),
            ),
            title: const Text('Paypal'),
            //  subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded6
                  ? Icons.check_circle_sharp
                  : Icons.radio_button_unchecked_sharp,
            ),
            children:[
              Row(
                children: [Text("         Credit on Card")],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(
                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Credit Card number ',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                // height: 50,
                width: DeviceUtils.getScaledWidth(context, 0.85),
                child: TextFormField(

                  //  controller: _userEmailController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    // prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),

                  ),

                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40 ,
                  ),
                  Text(
                    'Expire date',
                    style: TextStyle(
                      fontSize: 14,

                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    'CCV',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    //height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      // controller: _fNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontSize: 15),
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // height: 50,
                    width: DeviceUtils.getScaledWidth(context, 0.42),
                    child: TextFormField(
                      ///controller: _lNameController,
                      decoration: const InputDecoration(

                        border: OutlineInputBorder(),

                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Valid Last Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButtonWidget(
                    buttonText: 'Add',
                    buttonColor: AppColors.primaryColor,
                    onPressed: () {
                      Routes.navigateRootToScreen(context, Routes.card_details);
                    },
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded6 = expanded);
            },
          ),
        ],
      ),
      ),
    );
  }
}

