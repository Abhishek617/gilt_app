import 'package:flutter/material.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';

import '../../constants/colors.dart';
import '../../models/payment/payment_card_master.dart';
import '../../models/payment/wallet_balance_master.dart';
import '../../utils/Global_methods/GlobalStoreHandler.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_body_wrapper.dart';
import '../../widgets/rounded_button_widget.dart';

class SelectCardView extends StatefulWidget {
  const SelectCardView({Key? key}) : super(key: key);

  @override
  State<SelectCardView> createState() => _SelectCardViewState();
}

class _SelectCardViewState extends State<SelectCardView> {
  List<PaymentCardDetails> cardList = [];
  double payableAmount = 0;
  double walletBalance = 0;
  double walletDeduction = 0;
  double bankDeduction = 0;
  bool walletSelected = true;
  String fromScreen = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      fromScreen = args["fromScreen"];
      payableAmount = args["amount"];
      getWalletBalance();
    });
  }

  getWalletBalance() async {
    if (fromScreen != Routes.addmoney) {
      await GlobalStoreHandler.userStore.myWalletBalance(
          (WalletBalanceMaster master) {
        if (master.data != null) {
          walletBalance = master.data?.walletBalance ?? 0;
          setState(() {
            walletSelected = walletBalance > 0;
            checkWalletBalance();
          });
        }
        getSavedCards();
      }, (error) {
        print(error.toString());
        getSavedCards();
      });
    } else {
      getSavedCards();
    }
  }

  getSavedCards() {
    GlobalStoreHandler.userStore.getSavedCards((PaymentCardMaster master) {
      if (master != null) {
        cardList = master.list ?? [];
        if (walletBalance == 0 && cardList.isNotEmpty) {
          cardList[0].isSelected = true;
        }
      }
      setState(() {
        walletSelected = walletBalance > 0;
        checkWalletBalance();
      });
    }, (error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletBalanceLayout = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          walletBalance == 0
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                            value: walletSelected,
                            checkColor: Colors.white,
                            activeColor: AppColors.primaryColor,
                            onChanged: (bool? value) {
                              setState(() {
                                walletSelected = value!;
                                if (walletSelected) {
                                  cardList.forEach((element) {
                                    element.isSelected = false;
                                  });
                                } else if (cardList.isNotEmpty) {
                                  cardList[0].isSelected = true;
                                }
                                checkWalletBalance();
                              });
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Wallet Balance: \$$walletBalance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
          Text(
            'Payable amount: \$$payableAmount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          getWarningText().isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    getWarningText(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : Container(),
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
            'Choose Payment Method',
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
                    children: [
                      walletBalanceLayout,
                      SizedBox(
                        height: 20,
                      ),
                      cardList.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: cardList.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CardItem(
                                  cardDetails: cardList[index],
                                  onClick: () {
                                    cardList.forEach((element) {
                                      element.isSelected = false;
                                    });
                                    cardList[index].isSelected = true;
                                    if (!(walletDeduction > 0 &&
                                        bankDeduction > 0)) {
                                      walletSelected = false;
                                    }
                                    checkWalletBalance();
                                    setState(() {});
                                  },
                                );
                              },
                            )
                          : Container(),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: ElevatedButtonWidget(
                          buttonText: getConfirmButtonText(),
                          buttonColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (walletSelected) {
                              if (walletDeduction > 0 && bankDeduction > 0) {
                                if (cardList.isEmpty) {
                                  redirectToAddCard();
                                } else {
                                  checkCardSelected();
                                }
                              } else {
                                redirectToPayment();
                              }
                            } else if (cardList.isNotEmpty) {
                              checkCardSelected();
                            } else {
                              redirectToAddCard();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  void checkCardSelected() {
    bool cardSelected =
        cardList.where((element) => element.isSelected!).toList().length > 0;
    if (cardSelected) {
      redirectToPayment();
    } else {
      GlobalMethods.showErrorMessage(
          context, "Please select payment method", "Select payment");
    }
  }

  void redirectToPayment() {
    PaymentCardDetails paymentDetails = getSelectedCard()!;
    paymentDetails.walletDeduction = walletDeduction;
    paymentDetails.bankDeduction = bankDeduction;
    if (walletSelected) paymentDetails.type = "wallet";
    print(paymentDetails.toJson().toString());
    Routes.goBackWithData(context, paymentDetails);
  }

  void redirectToAddCard() {
    Routes.navigateToScreenWithCB(context, Routes.add_card, (val) {
      getSavedCards();
    });
  }

  void checkWalletBalance() {
    if (walletSelected) {
      if (walletBalance < payableAmount) {
        walletDeduction = walletBalance;
        bankDeduction = payableAmount - walletDeduction;
      } else {
        walletDeduction = payableAmount;
        bankDeduction = 0;
      }
    } else {
      walletDeduction = 0;
      bankDeduction = payableAmount;
    }
  }

  String getConfirmButtonText() {
    if (walletSelected &&
        walletDeduction > 0 &&
        bankDeduction > 0 &&
        cardList.isEmpty) {
      return "Add";
    } else if (walletSelected) {
      return "Confirm";
    } else if (cardList.isEmpty) {
      return "Add";
    } else {
      return "Confirm";
    }
  }

  String getWarningText() {
    if (walletDeduction > 0 && bankDeduction > 0) {
      return "\$$walletDeduction will be deducted from wallet and \$$bankDeduction will be deducted from selected payment method.";
    }
    return "";
  }

  PaymentCardDetails? getSelectedCard() {
    try {
      if (cardList.isNotEmpty) {
        List<PaymentCardDetails> selectedList =
            cardList.where((element) => element.isSelected!).toList();
        if (selectedList.isNotEmpty) return selectedList[0];
      }
    } catch (e) {
      print(e.toString());
    }
    return PaymentCardDetails();
  }
}

class CardItem extends StatelessWidget {
  PaymentCardDetails? cardDetails;
  final onClick;

  CardItem({this.cardDetails, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: AppColors.grayTextColor.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 6,
              )
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                      child: Text(
                          "${cardDetails!.type == "account" ? cardDetails!.bankName : cardDetails!.brand}")),
                ],
              ),
            ),
            Icon(
              cardDetails!.isSelected!
                  ? Icons.radio_button_checked_outlined
                  : Icons.radio_button_off_outlined,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
