import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  chat1() => Column(
        children: [
          Row(
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
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  height: 40,
                  width: 150,
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
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    
                      color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(17.00),
                      ),
                ),
              )
            ],
          ),
        ],
      );
  chat2() => Column(
    children: [
      Row(
        children: [

          Padding(
            padding: EdgeInsets.only(left: 125),
            child: Container(
              height: 40,
              width: 150,
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
          Align(
            alignment: Alignment.center,
            child: Stack(
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
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 60),
        child: Container(
          height: 40,
          width: 150,
          child: Padding(
            padding: EdgeInsets.only(top: 13.5),
            child: Text(
              '                       ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.cream_app,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(

            color: AppColors.cream_app,
            borderRadius: BorderRadius.circular(17.00),
          ),
        ),
      ),
    ],
  );
  chat3() => Column(
    children: [
      Row(
        children: [
          Align(
            alignment: Alignment.center,
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


          Padding(
            padding: EdgeInsets.only(right: 125),
            child: Container(
              height: 40,
              width: 150,
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
          ),

        ],
      ),
      Padding(
        padding: EdgeInsets.only(right: 60),
        child: Container(
          height: 40,
          width: 150,
          child: Padding(
            padding: EdgeInsets.only(top: 13.5),
            child: Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(

            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(17.00),
          ),
        ),
      ),
    ],
  );

  chat4() => Column(
    children: [
      Row(
        children: [

          Padding(
            padding: EdgeInsets.only(left: 125),
            child: Container(
              height: 40,
              width: 150,
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
          Align(
            alignment: Alignment.center,
            child: Stack(
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
          ),
        ],
      ),

    ],
  );


  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      isMenu: false,
      appBar: AppBar(
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

        child: Column(children: [
          Padding(padding:EdgeInsets.only(top:40)
          ),
          chat1(),
          chat2(),
          chat3(),
          chat4(),
          chat1(),
          chat4(),
          chat1(),
          chat2(),
          // BottomNavigationBar(
          //   type: BottomNavigationBarType.fixed,
          //   backgroundColor: AppColors.primaryColor,
          //   iconSize: 30,
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       label: '',
          //       icon: Icon(Icons.mic,color: Colors.white,),
          //     ),
          //
          //     BottomNavigationBarItem(
          //       label: "",
          //       icon: Icon(Icons.send, color: Colors.white,),
          //     ),
          //   ],
          // ),
        ]),



    );
  }
}
