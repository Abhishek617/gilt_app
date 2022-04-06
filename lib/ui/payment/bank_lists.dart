import 'package:flutter/material.dart';
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

class Bank_lists extends StatefulWidget {
  const Bank_lists({Key? key}) : super(key: key);

  @override
  State<Bank_lists> createState() => _Bank_listsState();
}

class _Bank_listsState extends State<Bank_lists> {


  bool viewVisible = false;
  //bool status = true;


  //static int _len = 8;
 //bool _isChecked = false;
  List<bool> _isChecked = [] ;


  bool checked = true;
  String _title = "Checkbox Demo";
 //String _getTitle() =>"Checkbox : Checked = ${isChecked.where((check) => check == true).length}, ""Unchecked = ${isChecked.where((check) => check == false).length}";

    //bool isChecked =  true;
  //bool checked = true;


  void showWidget(){
    setState(() {
      if (viewVisible = true){
        viewVisible = true;
      }else{
        viewVisible = false;
      }

    });
  }
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

    final icons = [
      "https://media.istockphoto.com/vectors/bank-building-icon-vector-id1204766394?s=612x612",
    "https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/344/external-credit-card-sales-vitaliy-gorbachev-flat-vitaly-gorbachev-2.png",
    "https://img.icons8.com/officel/344/mastercard-credit-card.png",
    "https://img.icons8.com/external-flat-juicy-fish/344/external-crypto-digital-nomad-flat-flat-juicy-fish.png",
    "https://img.icons8.com/ios/452/apple-pay.png",
    "https://img.icons8.com/fluency/344/android.png",
    "https://img.icons8.com/color/344/google-pay-india.png",
    "https://img.icons8.com/doodle/344/paypal.png"
  ];
  //late List<bool> _isChecked;

  @override
  void initState() {
   super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('Skip   ',style: TextStyle(color: Colors.black),)
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        //: Text('Skip'),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: AppLogoWidget(
                width: 140.0,
                height: 120.0,

              ),
                ),

            Container(
            //height: MediaQuery.of(context).size.height / 0,
              height: 450,
              width: MediaQuery.of(context).size.width / 1.03,
              child: ListView.builder(
                  itemCount: _texts.length,
                  itemBuilder: (BuildContext context,int index){
                    return ListTile(
                       leading: Icon(Icons.attach_money),
                        trailing:Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                          value: _isChecked[index],
                          onChanged: (val) { // This is where we update the state when the checkbox is tapped
                            setState(()
                            {
                              if(val == true){
                                _isChecked[index] = val!;
                                viewVisible = true;
                                //_isChecked= val!;
                              }else{
                                //_isChecked = false;
                                _isChecked[index] = val!;
                                viewVisible = false;
                              }

                            }

                            );
                          },
                        ),
                        title:Text(_texts[index])
                    );
                  }

              ),

            ),

            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: viewVisible,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Full name on the card',
                          style: TextStyle(
                            fontSize: 14,

                          ),
                        ),
                      ],
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
                    SizedBox(
                      height: 15,
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
                      width: 330,
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
                    SizedBox(
                      height: 15,
                      width: 20,
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
                          width: 162,
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
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButtonWidget(
                          buttonText: 'Add',
                          buttonColor: AppColors.primaryColor,
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
