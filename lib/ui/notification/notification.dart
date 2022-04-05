import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/device/device_utils.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  With_Button() => Container(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          children: [
            SizedBox(width: 15),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'David Siliba invite to JO Malone',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'iliba invite to JO Ma',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Accept'),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ))),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Reject',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 45),
              child: Text(
                'Just Now',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );

  Without_Button() => Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            SizedBox(width: 15),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'David Siliba invite to JO Malone',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'iliba invite to JO Ma',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Just Now',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
  List<String> item = [
    ' b',
    'c ',
    ' d',
    ' b',
    'c ',
    ' d',
    ' r',
    'n ',
    'y',
    'f',
    'm' ' b',
    'c ',
    ' d',
    ' r'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Notification'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1.10),
              height: DeviceUtils.getScaledHeight(context, 0.85),
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) =>
                    index.isOdd ? With_Button() : Without_Button(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
