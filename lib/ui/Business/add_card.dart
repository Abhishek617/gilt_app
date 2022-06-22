import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/payment/add_card_master.dart';
import 'package:guilt_app/models/payment/payment_card_master.dart';
import 'package:guilt_app/models/payment_method/payment_method_master.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:guilt_app/utils/card_utils/card_utils.dart';
import 'package:guilt_app/utils/encryption/card_encryption.dart';

import '../../constants/colors.dart';
import '../../utils/Global_methods/global.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_body_wrapper.dart';
import '../../widgets/rounded_button_widget.dart';
import '../../widgets/textfield_widget.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  GlobalKey<FormState> bankFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();
  final edCardNameController = TextEditingController();
  final edCardNumberController = TextEditingController();
  final edCardExpiryController = TextEditingController();
  final edCardCvvController = TextEditingController();

  final edAccountNameController = TextEditingController();
  final edAccountNumberController = TextEditingController();
  final edBankNameController = TextEditingController();
  final edRoutingNumberController = TextEditingController();
  List<PaymentMethod> methodList = [
    PaymentMethod(methodName: "Bank Account", method: "bankAccount"),
    PaymentMethod(
        methodName: "Credit/Debit card", method: "card", isSelected: true),
  ];
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  initState() {
    // edAccountNumberController.text = "204578441124512";
    // edRoutingNumberController.text = "121042882";

    edAccountNumberController.text = "304578441124541";
    edRoutingNumberController.text = "011401533";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imgLogo = Center(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: AppColors.grayTextColor.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(75))),
      ),
    );

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
          getTextfieldTitle(title: "Bank name"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edBankNameController,
            hintText: "",
            textInputType: TextInputType.text,
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter bank name";
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
              buttonText: "Add",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                GlobalMethods.hideKeyboard(context);
                if (bankFormKey.currentState!.validate()) {
                  addCardOrBankAccount(data: getBankParams());
                } else {
                  print('Error');
                }
              },
            ),
          )
        ],
      ),
    );

    final creditCardForm = Form(
      key: cardFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTextfieldTitle(title: "Full name on the card"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edCardNameController,
            hintText: "",
            textInputType: TextInputType.text,
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter name on the card.";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          getTextfieldTitle(title: "Credit card number"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edCardNumberController,
            hintText: "",
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberInputFormatter()
            ],
            suffixIcon: Icon(
              Icons.credit_card,
              color: Colors.black87.withOpacity(0.7),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "Enter card number";
              } else if (CardUtils.validateCardNumWithLuhnAlgorithm(
                      edCardNumberController.text.toString()) !=
                  null) {
                return "Invalid card.";
              }
              /* else if (!CreditCardValidator()
                  .validateCCNum(edCardNumberController.text)
                  .isPotentiallyValid) {
                return "Invalid card.";
              }*/
              else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextfieldTitle(title: "Credit card expiry"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFieldCustom(
                      controller: edCardExpiryController,
                      hintText: "",
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter()
                      ],
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter expiry.";
                        } else if (CardUtils.validateDate(
                                edCardExpiryController.text.toString()) !=
                            null) {
                          return "Invalid expiry date.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextfieldTitle(title: "Cvv"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormFieldCustom(
                      controller: edCardCvvController,
                      hintText: "",
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(3),
                      ],
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Cvv";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: ElevatedButtonWidget(
              buttonText: "Add",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                GlobalMethods.hideKeyboard(context);
                if (cardFormKey.currentState!.validate()) {
                  addCardOrBankAccount(data: getCardParams());
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
            'Add Card Details',
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
                      imgLogo,
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: methodList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          PaymentMethod method = methodList[index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              PaymentMethodItem(
                                paymentMethod: methodList[index],
                                onClick: () {
                                  setState(() {
                                    methodList.forEach((element) {
                                      element.isSelected = false;
                                    });
                                    methodList[index].isSelected = true;
                                  });
                                },
                              ),
                              if (method!.isSelected &&
                                  method!.method == "card")
                                creditCardForm,
                              if (method!.isSelected &&
                                  method!.method == "bankAccount")
                                bankAccountForm,
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ))));
  }

  String getCardParams() {
    List<String> expiryDate =
        CardUtils.getExpiryDate(edCardExpiryController.text);
    String expiry = "${expiryDate[0]}${expiryDate[1]}";
    var map = new Map<String, dynamic>();
    map['type'] = "card";
    map['brand'] = CardUtils.getBrandName(
        CardUtils.detectCCType(edCardNumberController.text));
    map['cardNumber'] = edCardNumberController.text.replaceAll(" ", "");
    map['expiry'] = expiry;
    map['nameOnAccount'] = edCardNameController.text;
    // map['bankAccountNum'] = "";
    // map['routingNumber'] = "";
    // map['bankName'] = "";
    return json.encode(map);
  }

  String getBankParams() {
    var map = new Map<String, dynamic>();
    map['type'] = "account";
    map['bankAccountNum'] = edAccountNumberController.text;
    map['routingNumber'] = edRoutingNumberController.text;
    map['bankName'] = edBankNameController.text;
    map['nameOnAccount'] = edAccountNameController.text;
    map['expiry'] = "";
    map['brand'] = "";
    map['cardNumber'] = "";
    return json.encode(map);
  }

  addCardOrBankAccount({required String data}) async {
    GlobalMethods.showLoader();
    _userStore.addCardOrBankAccount(data, (AddPaymentMaster paymentMaster) {
      GlobalMethods.hideLoader();
      if (paymentMaster != null) {
        if (paymentMaster.success!) {
          GlobalMethods.showSuccessMessage(
              context, paymentMaster.message!, "Add Payment");
          Routes.goBack(context);
        } else {
          GlobalMethods.showErrorMessage(
              context, paymentMaster.message!, "Add Payment");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
    });
  }
}

class PaymentMethodItem extends StatelessWidget {
  PaymentMethod? paymentMethod;
  Function? onClick;

  PaymentMethodItem({this.paymentMethod, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          onClick!();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Icon(Icons.image_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(child: Text(paymentMethod!.methodName)),
                ],
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Icon(
              paymentMethod!.isSelected
                  ? Icons.radio_button_on_outlined
                  : Icons.radio_button_off_outlined,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
