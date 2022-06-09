import 'package:flutter/material.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';

import '../../constants/colors.dart';
import '../../models/payment/payment_card_master.dart';
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

  getSavedCards() async {
    GlobalStoreHandler.userStore.getSavedCards((PaymentCardMaster master) {
      if (master != null) {
        setState(() {
          cardList = master.list ?? [];
          if (cardList.isNotEmpty) cardList[0].isSelected = true;
        });
      }
    }, (error) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getSavedCards();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          buttonText: "Confirm",
                          buttonColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            PaymentCardDetails paymentDetails =
                                getSelectedCard()!;
                            if (paymentDetails != null) {
                              Routes.goBackWithData(context, paymentDetails);
                            } else {
                              GlobalMethods.showErrorMessage(
                                  context,
                                  "Please select the card or account",
                                  "Select payment method");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  PaymentCardDetails? getSelectedCard() {
    try {
      return cardList.where((element) => element.isSelected!).toList()[0];
    } catch (e) {
      print(e.toString());
    }
    return null;
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
