import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/models/Chat/UserChatMessageListModel.dart';
import 'package:guilt_app/models/Chat/UserChatMessageListModel.dart';
import 'package:guilt_app/models/Chat/UserChatMessagesModel.dart';
import 'package:guilt_app/utils/Global_methods/GlobalSocket.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/widgets/custom_scaffold.dart';
import 'package:mobx/mobx.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SharedPreferenceHelper sharedPrefHelper;
  late TextEditingController _messageController;
  late ScrollController _controller;
  List<Messages> currentMessageList = [];
  var currentUserName = '';

  @observable
  UserChatMessageListModel loadMessageData = UserChatMessageListModel();

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _controller = ScrollController();
    currentUserName = G.socketUtils.userData.user.firstname +
        ' ' +
        G.socketUtils.userData.user.lastname;
    G.socketUtils.onLoadMessageListener(loadMessageHandler);
    G.socketUtils.onNewMessageListener(newMessageHandler);
  }

  loadMessageHandler(messageData) {
    if (mounted) {
      setState(() {
        loadMessageData = UserChatMessageListModel.fromJson(messageData);
        currentMessageList = loadMessageData?.messages ?? [];
        print('loadMessageHandler');
        print(currentMessageList);
        if (currentMessageList.length > 0) {
          WidgetsBinding.instance?.addPostFrameCallback((_) => {
                _controller.animateTo(
                  0.0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                )
              });
        }
      });
    }
  }

  newMessageHandler(messageData) {
    print('new messageData');
    print(messageData);
    messageData  = CatchSentMessageModel.fromJson(messageData);
    if (mounted) {
      setState(() {
        // Messages newMsg = Messages.fromJson(messageData.data);
        currentMessageList = [...currentMessageList, messageData.data];
        if (currentMessageList.length > 0) {
          WidgetsBinding.instance?.addPostFrameCallback((_) =>
          {
            _controller.animateTo(
              0.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            )
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    //G.socketUtils.socketDisconnect();
    super.dispose();
  }

  getChatTitle() {
    // if(currentChatRoom.type == 'event'){
    if (loadMessageData != null) {
      return Observer(
        builder: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              child: CircleAvatar(
                backgroundColor: AppColors.cream_app,
                radius: 20,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      loadMessageData?.threadUserInfo?.profile ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnngxCpo8jS7WE_uNWmlP4bME_IZkXWKYMzhM2Qi1JE_J-l_4SZQiGclMuNr4acfenazo&usqp=CAU',
                    ),
                    onBackgroundImageError: (e, s) {
                      debugPrint('image issue, $e,$s');
                    }),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              (loadMessageData?.threadUserInfo?.firstName ?? '') +
                  ' ' +
                  (loadMessageData?.threadUserInfo?.lastName ?? ''),
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
    // }
  }

  sender(messageDetails) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(minWidth: 50),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    messageDetails.message ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.cream_app,
                    borderRadius: BorderRadius.circular(17.00),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  receiver(messageDetails) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 50),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  messageDetails.message ?? '',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
        title: getChatTitle(),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 10,
                width: 10,
              ),
              Observer(
                  builder: (_) => currentMessageList != null
                      ? SingleChildScrollView(
                          child: Container(
                            width: DeviceUtils.getScaledWidth(context, 1.00),
                            height: DeviceUtils.getScaledHeight(context, 0.85),
                            child: ListView.builder(
                              controller: _controller,
                              itemCount: currentMessageList.length,
                              itemBuilder: (context, index) =>
                              (currentMessageList[index].user?.firstName).toString() + ' ' + (currentMessageList[index].user?.lastName).toString() ==
                                          currentUserName
                                      ? sender(currentMessageList[index])
                                      : receiver(currentMessageList[index]),
                            ),
                          ),
                        )
                      : Text('Start a chat')),
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
                      controller: _messageController,
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
                    onPressed: () {
                      G.socketUtils?.sendMessage(_messageController.text,
                          loadMessageData?.threadUserInfo, 'text', () {
                        _messageController.text = '';
                      });
                    },
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
