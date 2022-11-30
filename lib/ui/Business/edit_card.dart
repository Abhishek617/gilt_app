import 'package:flutter/material.dart';

import '../../constants/colors.dart';
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
  final edCardNameController = new TextEditingController();
  final edCardNumberController = new TextEditingController();
  final edCardExpiryController = new TextEditingController();
  final edCardCvvController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    Widget getTextfieldTitle({String? title}) {
      return Text(title!, style: TextStyle(fontSize: 13),);
    }

    final creditCardForm = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTextfieldTitle(title: "Full name on the card"),
          SizedBox(height: 5,),
          TextFormFieldCustom(
            controller: edCardNameController,
            hintText: "",
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 20,),
          getTextfieldTitle(title: "Credit card number"),
          SizedBox(height: 5,),
          TextFormFieldCustom(
            controller: edCardNumberController,
            hintText: "",
            textInputType: TextInputType.number,
            suffixIcon: Icon(Icons.credit_card, color: Colors.black87.withOpacity(0.7),),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextfieldTitle(title: "Credit card expiry"),
                    SizedBox(height: 5,),
                    TextFormFieldCustom(
                      controller: edCardExpiryController,
                      hintText: "",
                      textInputType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24,),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTextfieldTitle(title: "Cvv"),
                    SizedBox(height: 5,),
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
          SizedBox(height: 24,),
          Center(
            child: ElevatedButtonWidget(
              buttonText: "Confirm",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onPressed: (){},
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      creditCardForm,
                    ],
                  ),
                ))));
  }
}
