import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';

import '../../constants/colors.dart';
import '../../models/payment/add_card_master.dart';
import '../../models/payment/payment_card_master.dart';
import '../../stores/user/user_store.dart';
import '../../utils/Global_methods/global.dart';
import '../../utils/card_utils/card_utils.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_body_wrapper.dart';
import '../../widgets/rounded_button_widget.dart';
import '../../widgets/textfield_widget.dart';

class EditCard extends StatefulWidget {
  const EditCard({Key? key}) : super(key: key);

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
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

  final UserStore _userStore = UserStore(getIt<Repository>());
  PaymentCardDetails? paymentData;
  String? accountNumberHint;
  String? cardNumberHint;
  String? cardExpiryHint;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      paymentData =
          ModalRoute.of(context)!.settings.arguments as PaymentCardDetails;
      if (paymentData != null) {
        if (paymentData!.type == "card") {
          edCardNameController.text = paymentData?.nameOnAccount ?? "";
          cardExpiryHint =
              CardUtils.getFormattedExpiryDate(paymentData?.expiry ?? "");
          cardNumberHint =
              "************${paymentData?.cardLastFourDigit ?? ""}";
        } else {
          edAccountNameController.text = paymentData?.nameOnAccount ?? "";
          edBankNameController.text = paymentData?.bankName ?? "";
          accountNumberHint =
              "************${paymentData?.bankAccountNumLastSixDigit ?? ""}";
          edRoutingNumberController.text =
              "${paymentData?.routingNumberLastFourDigit ?? ""}";
        }
      }
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
            hintText: accountNumberHint ?? "",
            textInputType: TextInputType.number,
            suffixIcon: Icon(
              Icons.credit_card,
              color: Colors.black87.withOpacity(0.7),
            ),
            /*validator: (val) {
              if (val!.isEmpty) {
                return "Enter account number";
              } else {
                return null;
              }
            },*/
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
              buttonText: "Confirm",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                GlobalMethods.hideKeyboard(context);
                if (bankFormKey.currentState!.validate()) {
                  editCardOrBankAccount(
                      id: paymentData!.id, data: getBankParams());
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
            hintText: cardNumberHint ?? "",
            textInputType: TextInputType.number,
            suffixIcon: Icon(
              Icons.credit_card,
              color: Colors.black87.withOpacity(0.7),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return null;
              } else if (CardUtils.validateCardNumWithLuhnAlgorithm(
                      edCardNumberController.text.toString()) !=
                  null) {
                return "Invalid card.";
              } else {
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
                      hintText: cardExpiryHint ?? "",
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter()
                      ],
                      validator: (val) {
                        if (val!.isEmpty) {
                          return null;
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
              buttonText: "Confirm",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                GlobalMethods.hideKeyboard(context);
                if (cardFormKey.currentState!.validate()) {
                  editCardOrBankAccount(
                      id: paymentData!.id, data: getCardParams());
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
            'Edit Card Details',
          ),
          centerTitle: true,
        ),
        body: CustomBodyWrapper(
            child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: paymentData != null
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            paymentData!.type == "card"
                                ? creditCardForm
                                : bankAccountForm,
                          ],
                        ),
                      )
                    : Container())));
  }

  String getCardParams() {
    String expiry = "";
    if (edCardExpiryController.text.isNotEmpty) {
      List<String> expiryDate =
          CardUtils.getExpiryDate(edCardExpiryController.text);
      expiry = "${expiryDate[0]}${expiryDate[1]}";
    }
    var map = new Map<String, dynamic>();
    map['type'] = "card";
    map['brand'] =
        CardUtils.getCardTypeFrmNumber(edCardNumberController.text) ==
                CardType.MasterCard
            ? "master"
            : CardUtils.getCardTypeFrmNumber(edCardNumberController.text) ==
                    CardType.Visa
                ? "visa"
                : "card";
    map['cardNumber'] = edCardNumberController.text.isNotEmpty
        ? edCardNumberController.text
        : paymentData!.cardLastFourDigit!;
    map['expiry'] = expiry.isNotEmpty ? expiry : paymentData!.expiry!;
    map['nameOnAccount'] = edCardNameController.text;
    return json.encode(map);
  }

  String getBankParams() {
    var map = new Map<String, dynamic>();
    map['type'] = "account";
    if (edAccountNumberController.text.isNotEmpty)
      map['bankAccountNum'] = edAccountNumberController.text;
    map['routingNumber'] = edRoutingNumberController.text;
    map['bankName'] = edBankNameController.text;
    map['nameOnAccount'] = edAccountNameController.text;
    return json.encode(map);
  }

  editCardOrBankAccount({required id, required String data}) async {
    GlobalMethods.showLoader();
    _userStore.editCardOrBankAccount(id, data,
        (AddPaymentMaster paymentMaster) {
      GlobalMethods.hideLoader();
      if (paymentMaster != null) {
        if (paymentMaster.success!) {
          GlobalMethods.showSuccessMessage(
              context, paymentMaster.message!, "Edit Payment Method");
          Routes.goBack(context);
        } else {
          GlobalMethods.showErrorMessage(
              context, paymentMaster.message!, "Edit Payment Method");
        }
      }
    }, (error) {
      GlobalMethods.hideLoader();
      print(error.toString());
      GlobalMethods.showErrorMessage(
          context, "Something went wrong!", "Edit Payment Method");
    });
  }
}
