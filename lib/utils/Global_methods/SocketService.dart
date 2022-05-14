import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/data/sharedpref/constants/preferences.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Chat/SocketUserModel.dart';
import 'package:guilt_app/models/Chat/roomListModel.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  late IO.Socket _socket;
  late SocketUserModel socketUserData;

  final UserStore _userStore = UserStore(getIt<Repository>());

  @observable
  late var userData;

  @observable
  var currentChatRoom;

  @observable
  var currentMessageList;

  @observable
  List<Rooms> roomList = [];

// Connection data
  static String _connectUrl = Endpoints.baseUrl;

  // Events
  static const String ERROR = 'error';
  static const String GET_USER_DATA = 'user_data';
  static const String JOIN_USER_PRIVATE_CHAT = 'userJoinPrivate';
  static const String JOIN_USER_BUSINESS_CHAT = 'userJoinBusiness';
  static const String JOIN_USER_EVENT_CHAT = 'userJoinEvent';
  static const String DISCONNECT_USER = 'disconnect';
  static const String GET_ROOM_LIST = 'roomList';
  static const String GET_MESSAGE_LIST = 'loadMessage';
  static const String SEND_NEW_MESSAGE = 'sendMessage';

  @action
  void initSocket() {
    print('Connecting to chat service');
    // String registrationToken = await getFCMToken();
    SharedPreferences.getInstance().then((preference) {
      var aToken = preference.getString(Preferences.auth_token);
      userData = GetProfileResponseModal.fromJson(
          jsonDecode(preference.getString(Preferences.profileData).toString()));
      var userFullName = userData.user.firstname + ' ' + userData.user.lastname;
      print('aToken');
      print(aToken);
      print('userData');
      print(userData);
      if (aToken != null) {
        _socket = IO.io(_connectUrl, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
          'query': {
            'userName': userFullName,
          }
        });
        _socket.io.options['extraHeaders'] = {
          'token': 'Bearer $aToken'
        }; // Update the extra headers.
        _socket.connect();
        _socket.onConnect((sUserData) {
          print('connected to websocket');
          print(sUserData);
          if (sUserData != null) {
            socketUserData = sUserData;
          } else {
            getUserData((data) {
              print('socketUserData');
              print(data);
              socketUserData = data;
            });
          }
        });
      }
    });
  }

  @action
  void joinChat(roomData, callback) {
    _socket.emit(JOIN_USER_PRIVATE_CHAT, {'phone': roomData.phone});
    _socket.on(JOIN_USER_PRIVATE_CHAT, (response) {
      callback(response);
    });
  }
getUserData(userDataHandler){
  _socket.emit(GET_USER_DATA);
  _socket.on(GET_USER_DATA, (response) {
    print('SocketUserData:');
    print(response);
    var uD = SocketUserModel.fromJson(response);
    userDataHandler(uD);
  });
}
  setOnMessageBackFromServer(Function onMessageBackFromServer) {
    _socket.on(SEND_NEW_MESSAGE, (data) {
      onMessageBackFromServer(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.on('error', (error) {
      print('---------------Socket Error occurred--------------');
      print(error);
      onError(error);
      socketDisconnect();
      initSocket();
    });
  }

  @action
  handleRoomList(roomListListener) {
    if (_socket != null) {
      _socket.emit(GET_ROOM_LIST);
      print('emitted room List');
      _socket.off(GET_ROOM_LIST);
      _socket.on(GET_ROOM_LIST, roomListListener);
    }
  }

  onLoadMessageListener(loadMessageHandler) {
    _socket.emit(GET_MESSAGE_LIST);
    _socket.on(GET_MESSAGE_LIST, (messageList) {
      loadMessageHandler(messageList);
    });
  }
  onNewMessageListener(newMessageHandler) {
    _socket.on(SEND_NEW_MESSAGE, (newMessage) {
      newMessageHandler(newMessage);
    });
  }

  @action
  void joinPrivateUser(userData) {
    currentChatRoom = userData;
    _socket.emit(JOIN_USER_PRIVATE_CHAT, {
      "type": "private",
      "sqlId": 3, // userid of the user whom you want to chat
      "user_id": socketUserData.sId // mongodb userid of the loggedin user
    });
    _socket.on('loadMessage', (messages) {
      currentMessageList = messages.cast<String, dynamic>();
      print('onLoadMessage');
      print(currentMessageList);
    });
  }

  @action
  void sendMessage(textMessage, threadInfo,type, callback) {
    String messageText = textMessage.trim();
    print(currentMessageList);
    print(currentChatRoom);
    print(messageText);
    if (messageText != '') {
      var messagePost = {
        "room_key": "3_14",
        "senderUserId": socketUserData.sId,
        // mongodb userid of the loggedin user
        "message": messageText,
        // actual message, in case of file you can send file location here or send it in file object
        "username": (socketUserData.firstName ?? '') + ' ' + (socketUserData.lastName ?? ''),
        // sender username
        "user_type": userData.user.roleId ?? '1',
        // pass user role
        "userSqlId": socketUserData.sqlId,
        // loggedin user sqlId,
        "message_type": type
      };
      _socket.emit('sendMessage', messagePost);
      callback();
    }
  }

  @ConnectionState.active
  void socketDisconnect() {
    if (_socket != null) {
      _socket.disconnect();
      print(_socket);
    }
  }
}
