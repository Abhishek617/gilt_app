import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../utils/device/device_utils.dart';
import '../../widgets/custom_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  reciver() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.32),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, 0.44),
                  height: DeviceUtils.getScaledHeight(context, 0.05),
                  child: Padding(
                    padding: EdgeInsets.only(top: 13.5),
                    child: Text(
                      'Hi! About that Party....',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.cream_app,
                    borderRadius: BorderRadius.circular(17.00),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 00.0, bottom: 00.0, right: 25.0),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  sender() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 00.0, bottom: 00.0, right: 10.0),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: DeviceUtils.getScaledWidth(context, 0.44),
                height: DeviceUtils.getScaledHeight(context, 0.05),
                child: Padding(
                  padding: EdgeInsets.only(top: 13.5),
                  child: Text(
                    'Hi! About that Party....',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(17.00),
                ),
              ),
            ],
          ),
        ],
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
          title: Column(
            children: [
              Text('Evening of Smooth Jazz        '),
              Row(
                children: [
                  Text(
                    '             Hosted by',
                    style: TextStyle(fontSize: 12),
                  ),
                  Icon(
                    Icons.person_pin,
                    size: 20,
                  ),
                  Text(
                    'Michale Scott',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          )),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 10,
                width: 10,
              ),
              SingleChildScrollView(
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, 1.10),
                  height: DeviceUtils.getScaledHeight(context, 0.85),
                  child: ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) =>
                        index.isOdd ? reciver() : sender(),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.attach_file,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Write message...",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(7.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
