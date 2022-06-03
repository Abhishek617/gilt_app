import 'package:flutter/material.dart';
import 'package:guilt_app/models/payment_method/payment_method_master.dart';

import '../../constants/colors.dart';
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
  final edCardNameController = TextEditingController();
  final edCardNumberController = TextEditingController();
  final edCardExpiryController = TextEditingController();
  final edCardCvvController = TextEditingController();

  final edAccountNameController = TextEditingController();
  final edAccountNumberController = TextEditingController();
  List<PaymentMethod> methodList = [
    PaymentMethod(methodName: "Bank Account", method: "bankAccount"),
    PaymentMethod(
        methodName: "Credit/Debit card", method: "card", isSelected: true),
  ];

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

    final bankAccountForm = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTextfieldTitle(title: "Full name"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edCardNameController,
            hintText: "",
            textInputType: TextInputType.text,
          ),
          SizedBox(
            height: 20,
          ),
          getTextfieldTitle(title: "Account number"),
          SizedBox(
            height: 5,
          ),
          TextFormFieldCustom(
            controller: edCardNumberController,
            hintText: "",
            textInputType: TextInputType.number,
            suffixIcon: Icon(
              Icons.credit_card,
              color: Colors.black87.withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: ElevatedButtonWidget(
              buttonText: "Add",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: () {},
            ),
          )
        ],
      ),
    );

    final creditCardForm = Container(
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
            suffixIcon: Icon(
              Icons.credit_card,
              color: Colors.black87.withOpacity(0.7),
            ),
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
              onPressed: () {},
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
                              SizedBox(height: 8,),
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
