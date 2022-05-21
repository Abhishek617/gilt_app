import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';

class BusinessPayment extends StatefulWidget {
  const BusinessPayment({Key? key}) : super(key: key);

  @override
  State<BusinessPayment> createState() => _BusinessPaymentState();
}


// List of items in our dropdown menu

class _BusinessPaymentState extends State<BusinessPayment> {
  String selectedDropdownValue = 'Select Your Business';
  var items = [
    'Select Your Business',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Routes.goBack(context);
          },
          child: Icon(
            Icons.close, color: Colors.black,
            //color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: DeviceUtils.getScaledWidth(context, 0.20),
            ),
            Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  Container(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: DeviceUtils.getScaledWidth(context, 0.15),
                      height: DeviceUtils.getScaledWidth(context, 0.15),
                      fit: BoxFit.cover,
                    ),
                  ),
                ])),
            SizedBox(
              height: 15,
            ),
            Text(
              'Pritesh',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '+91 9889787666',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: DeviceUtils.getScaledWidth(context, 0.65),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,0}')),
                ],
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    hintText: "\$ 0",
                    fillColor: Colors.black12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your Business",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Row(
                    children: [
                      Container(
                        child: DropdownButton(

                          // Initial Value
                          value: selectedDropdownValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(item)),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          Container(
                              width: DeviceUtils.getScaledWidth(context, 0.60),
                              height: DeviceUtils.getScaledHeight(context, 0.06),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                    // label: Text(
                                    //   "Location",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold, color: Colors.black),
                                    // ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.primaryColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Enter Location'),
                              )),
                          Container(
                            width: DeviceUtils.getScaledWidth(context, 0.30),
                            height: DeviceUtils.getScaledHeight(context, 0.05),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 13,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Set on Map',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                onPressed: () => {}),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 4,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter your description',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.44),
                        child: ElevatedButtonWidget(
                          buttonColor: Colors.white12,
                          onPressed: () {},
                          buttonText: ('Cancel'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.44),
                        child: ElevatedButtonWidget(
                          buttonColor: AppColors.primaryColor,
                          onPressed: () {},
                          buttonText: ('Request'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
