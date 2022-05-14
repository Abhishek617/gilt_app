import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/models/Chat/roomListModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/Global_methods/global.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/custom_body_wrapper.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobx/mobx.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @observable
  List<Rooms> screenRoomList = [];

  @override
  void initState() {
    G.socketUtils.handleRoomList((roomListData) {
      setState(() {
        print('roomListData');
        print(roomListData);
        var data = RoomListModel.fromJson(roomListData);
        screenRoomList = data.roomData?.rooms ?? [];
      });
    });
    super.initState();
  }

  bindSocketListeners() {}

  Message_list(msgData) => GestureDetector(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 22,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          msgData.users[0].profile ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                        ),
                        onBackgroundImageError: (e, s) {
                          debugPrint('image issue, $e,$s');
                        }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msgData.lastMessage.username ?? 'No Name',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          msgData.lastMessage.content ?? 'No Message',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Jiffy(msgData.lastMessageAt, "yyyy-MM-ddThh:mm:ssZ")
                            .fromNow(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      msgData.unreadMessageCount != 0
                          ? Container(
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
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black12,
              //color of divider
              height: 10,
              //height spacing of divider
              thickness: 1,
              //thickness of divier line
              indent: 16,
              //spacing at the start of divider
              endIndent: 16, //spacing at the end of divider
            ),
          ],
        ),
        onTap: () {
          G.socketUtils.joinPrivateUser(msgData);
          if (msgData.lastMessage.messageType == 'private') {
            Routes.navigateToScreen(context, Routes.chat);
          } else if (msgData.lastMessage.messageType == 'event') {
            Routes.navigateToScreen(context, Routes.event_chat);
          } else {
            Routes.navigateToScreen(context, Routes.business_chat);
          }
        },
      );

  // Message_list_withoutcount(msgData) => GestureDetector(
  //     child: Column(
  //       children: [
  //         Container(
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 height: 10,
  //                 width: 20,
  //               ),
  //               Column(
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Stack(
  //                       children: [
  //                         Container(
  //                           child: Image.network(
  //                             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
  //                             width: 60,
  //                             height: 60,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 10,
  //                 width: 20,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     msgData.lastMessage.username ?? 'No Name',
  //                     style: TextStyle(
  //                       color: AppColors.primaryColor,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                   Text(
  //                     msgData.lastMessage.content ?? 'No Message',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 10,
  //                 width: 60,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     msgData.lastMessageAt ?? 'Just Now',
  //                     style: TextStyle(
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Divider(
  //           color: Colors.black12,
  //           //color of divider
  //           height: 20,
  //           //height spacing of divider
  //           thickness: 1,
  //           //thickness of divier line
  //           indent: 20,
  //           //spacing at the start of divider
  //           endIndent: 20, //spacing at the end of divider
  //         ),
  //       ],
  //     ),
  //     onTap: () {
  //       G.socketUtils.joinPrivateUser(msgData);
  //       Routes.navigateToScreenWithArgs(context, Routes.chat, msgData);
  //     });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Open contacts');
          GlobalMethods.askPermissions(
              context, Routes.add_new_chat_contact);
        },
        child: Icon(Icons.add_comment, color: AppColors.primaryColor,),
      ),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Center(child: Text('Messages')),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     padding: EdgeInsets.only(
        //       top: 10.0,
        //       bottom: 5.0,
        //     ),
        //     icon: Icon(Icons.circle_notifications),
        //     onPressed: () {
        //       Routes.navigateToScreen(context, Routes.notifi);
        //     },
        //   ),
        // ],
      ),
      body: CustomBodyWrapper(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            screenRoomList.length > 0
                ? SingleChildScrollView(
                    child: Container(
                      width: DeviceUtils.getScaledWidth(context, 1.05),
                      height: DeviceUtils.getScaledHeight(context, 0.73),
                      child: Observer(
                          builder: (_) => ListView.builder(
                              itemCount: screenRoomList.length,
                              itemBuilder: (context, index) =>
                                  Message_list(screenRoomList[index]))),
                    ),
                  )
                : Center(
                    child: Text('No Messages Found'),
                  ),
          ],
        ),
      ),
    );
  }
}
