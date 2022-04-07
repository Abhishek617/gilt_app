import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';

import '../../utils/device/device_utils.dart';

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  int expandedItem = -1;
  bool isEdit = false;
  Expenselist(index) => Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Card(
                child: Row(
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {setState(() {
                        expandedItem = index;
                      });},
                      icon: Icon(
                        Icons.play_circle_outline_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('A Virtual Evening of Smooth Jazz',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text('13 January 2022 2:00PM',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(
                  height: 3,
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('- \$500.00',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text('settled',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            )),
          )
        ],
      );

  detailldata(index) => Column(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Card(
            child: Column(children: [
             Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {setState(() {
                          expandedItem = -1;
                        });},
                        icon: Icon(
                          Icons.arrow_circle_down_sharp,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('A Virtual Evening of Smooth Jazz',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 3,
                        width: 3,
                      ),
                      Text('13 January 2022 2:00PM',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('- \$500.00',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 3,
                        width: 3,
                      ),
                      Text('settled',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
                //color of divider
                height: 20,
                //height spacing of divider
                thickness: 1,
                //thickness of divier line
                indent: 20,
                //spacing at the start of divider
                endIndent: 20, //spacing at the end of divider
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 18.0, right: 10.0),
                          child: Image.network(
                            'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                            width: 55,
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pay to Hotel Room',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 3,
                        width: 3,
                      ),
                      Text('13 January 2022 2:00PM',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                    width: 65,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('- \$300.00',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 18.0, right: 10.0),
                          child: Image.network(
                            'https://i.pinimg.com/474x/e7/0b/30/e70b309ec42e68dbc70972ec96f53839.jpg',
                            width: 55,
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pay to Food and Drink',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 3,
                        width: 3,
                      ),
                      Text('13 January 2022 2:00PM',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('- \$200.00',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
  ],
            )
        ),
      ),
    ],
  );

  checkdata(index) {
    return expandedItem == index ? detailldata(index) : Expenselist(index);
  }


  List<String> item = [
    ' b',
    'c ',
    ' d',
    ' d',
    'd ',
    ' b',
    'c ',
    ' d',
    ' d',
    'd ',
    'c',
    'f',
    's'
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 17,
          ),
        ),
        shadowColor: Colors.transparent,
        title: Text('       Expenses History'),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            width: 10,
          ),
          Container(
            height: DeviceUtils.getScaledHeight(context, 0.83),
            child: ListView.builder(
              itemCount: item.length,

              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
              checkdata(index),
            ),

          ),
        ],
      ),
    );
  }
}
