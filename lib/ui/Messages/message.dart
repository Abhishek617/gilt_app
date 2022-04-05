import 'package:flutter/material.dart';
import 'package:guilt_app/constants/colors.dart';

import '../../utils/routes/routes.dart';
import '../../widgets/custom_scaffold.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Message_list() => GestureDetector(
    child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 00.0, bottom: 00.0, right: 0.0),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 00),
                child: Column(
                  children: [
                    Text(
                      'David Siliba',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15.0, top: 10.0, bottom: 0.0, right: 00.0),
                      child: Text(
                        'Hey! How its Going',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 77, right: 25),
                child: Column(
                  children: [
                    Text(
                      'Just Now',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '9',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    onTap: () => {
      Routes.navigateToScreen(context, Routes.chat)
    },
  );

  Message_list_withoutcount() => Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 25.0, top: 00.0, bottom: 00.0, right: 0.0),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 00),
              child: Column(
                children: [
                  Text(
                    'David Siliba',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, top: 10.0, bottom: 0.0, right: 00.0),
                    child: Text(
                      'Hey! How its Going',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 00, left: 77, right: 25, bottom: 32),
              child: Column(
                children: [
                  Text(
                    'Just Now',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: true,
      isTab: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Center(child: Text('Messages')),
        actions: [
          IconButton(
            padding: EdgeInsets.only(
                left: 00.0, top: 10.0, bottom: 5.0, right: 00.0),
            icon: Icon(Icons.circle_notifications),
            onPressed: () {
              Routes.navigateToScreen(context, Routes.notifi);
            },
          ),

        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(padding: EdgeInsets.only(top: 15)),
            Message_list(),
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
            Message_list(),
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
            Message_list_withoutcount(),
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
            Message_list_withoutcount(),
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
            Message_list_withoutcount(),
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
            Message_list_withoutcount(),
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
            Message_list_withoutcount(),
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
            Message_list_withoutcount(),
          ],
        ),
      ),
    );
  }
}
