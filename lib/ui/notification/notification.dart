import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  With_Button() => Container(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 00.0, right: 5.0),
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, top: 15.0, bottom: 00.0, right: 00.0),
                  child: Text(
                    'David Siliba invite to JO Malone',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, top: 3.0, bottom: 00.0, right: 90.0),
                  child: Text(
                    'iliba invite to JO Ma',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0, right: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Accept'),
                          style: ButtonStyle(

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 0, right: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Reject',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                        )),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 10.0, bottom: 60.0, right: 25.0),
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
        padding: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 00.0, right: 5.0),
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, top: 15.0, bottom: 00.0, right: 00.0),
                  child: Text(
                    'David Siliba invite to JO Malone',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, top: 3.0, bottom: 20.0, right: 90.0),
                  child: Text(
                    'iliba invite to JO Ma',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, top: 20.0, bottom: 40.0, right: 25.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Notification'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: With_Button(),
            ),
            Container(
              child: Without_Button(),
            ),
            Container(
              child: With_Button(),
            ),
            Container(
              child: With_Button(),
            ),
            Container(
              child: Without_Button(),
            ),
            Container(
              child: Without_Button(),
            ),
            Container(
              child: Without_Button(),
            ),
            Container(
              child: With_Button(),
            ),
            Container(
              child: Without_Button(),
            ),
          ],
        ),
      ),
    );
  }
}
