import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/models/success_master.dart';

import '../../constants/colors.dart';
import '../../data/repository.dart';
import '../../di/components/service_locator.dart';
import '../../stores/user/user_store.dart';
import '../../utils/Global_methods/GlobalStoreHandler.dart';
import '../../utils/Global_methods/global.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_body_wrapper.dart';
import '../../widgets/rounded_button_widget.dart';
import '../../widgets/textfield_widget.dart';

class SendMoneyToBank extends StatefulWidget {
  const SendMoneyToBank({Key? key}) : super(key: key);

  @override
  State<SendMoneyToBank> createState() => _SendMoneyToBankState();
}

class _SendMoneyToBankState extends State<SendMoneyToBank> {
  GlobalKey<FormState> bankFormKey = GlobalKey<FormState>();

  final edAccountNameController = TextEditingController();
  final edAmountController = TextEditingController();
  final edAccountNumberController = TextEditingController();
  final edRoutingNumberController = TextEditingController();
  double? mWalletBalance;

  @override
  initState() {
    edAccountNumberController.text = "204578441124512";
    edRoutingNumberController.text = "121042882";
    super.initState();
    Future.delayed(Duration.zero, () {
      mWalletBalance = ModalRoute.of(context)!.settings.arguments as double;
      edAmountController.text = mWalletBalance.toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getTextfieldTitle({String? title}) {
      return Text(
        title!,
        style: TextStyle(fontSize: 13),
      );
    }

    final bankAccountForm = Form(
      key: bankFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet Balance: \$$mWalletBalance',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          getTextfieldTitle(title: "Amount"),
          SizedBox(
            height: 5,
          ),
          mWalletBalance != null
              ? TextFormFieldCustom(
                  controller: edAmountController,
                  hintText: "",
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    NumericalRangeFormatter(min: 1, max: mWalletBalance ?? 1)
                  ],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter amount";
                    } else {
                      return null;
                    }
                  },
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          getTextfieldTitle(title: "Full name"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edAccountNameController,
            hintText: "",
            textInputType: TextInputType.text,
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter account name";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          getTextfieldTitle(title: "Account number"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edAccountNumberController,
            hintText: "",
            textInputType: TextInputType.number,
            suffixIcon: Icon(
              Icons.credit_card,
              color: Colors.black87.withOpacity(0.7),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter account number";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          getTextfieldTitle(title: "Routing number"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edRoutingNumberController,
            hintText: "",
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter routing number";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: ElevatedButtonWidget(
              buttonText: "Send Money To Bank",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                GlobalMethods.hideKeyboard(context);
                if (bankFormKey.currentState!.validate()) {
                  creditBankAccount();
                } else {
                  print('Error');
                }
              },
            ),
          )
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Routes.goBack(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              //color: Colors.black,
              size: 16,
            ),
          ),
          title: Text(
            'Send Money to Bank',
          ),
          centerTitle: true,
        ),
        body: CustomBodyWrapper(
            child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bankAccountForm,
                    ],
                  ),
                ))));
  }

  creditBankAccount() {
    GlobalMethods.showLoader();
    GlobalStoreHandler.userStore.creditBankAccount(getBankParams(),
        (SuccessMaster master) {
      GlobalMethods.hideLoader();
      if (master != null) {
        if (master.success != null && master.success!) {
          GlobalMethods.showSuccessMessage(context,
              master.message ?? "Money sent to account.", "Send money to bank");
          Routes.goBackWithData(context, true);
        } else if (master.message != null) {
          GlobalMethods.showErrorMessage(
              context, master.message!, "Send money to bank");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }

  String getBankParams() {
    var map = new Map<String, dynamic>();
    map['accountNumber'] = edAccountNumberController.text;
    map['routingNumber'] = edRoutingNumberController.text;
    map['amount'] = double.parse(edAmountController.text);
    return json.encode(map);
  }
}
