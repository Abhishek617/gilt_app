import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/data/sharedpref/constants/preferences.dart';
import 'package:guilt_app/data/sharedpref/shared_preference_helper.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Chat/SocketUserModel.dart';
import 'package:guilt_app/models/Chat/UserChatMessageListModel.dart';
import 'package:guilt_app/models/Chat/UserChatMessagesModel.dart';
import 'package:guilt_app/models/Chat/roomListModel.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  late IO.Socket _socket;
  late SocketUserModel socketUserData;
  bool isSocketConnected = false;
  final UserStore _userStore = UserStore(getIt<Repository>());

  @observable
  late var userData;

  @observable
  var joinedUserData;
  @observable
  var joinedEventData;
  @observable
  var joinedBusinessData;
  @observable
  var currentChatRoom;
  @observable
  var currentChatRoomKey;
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
  static const String MARK_THREAD_AS_READ = 'markReadThreadMessages';

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
        if (isSocketConnected) {
          _socket.disconnect();
        }
        _socket.connect();
        _socket.onConnect((sUserData) {
          print('connected to websocket');
          isSocketConnected = true;
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

  getUserData(userDataHandler) {
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

  emitRoomList() {
    _socket.emit(GET_ROOM_LIST);
  }

  @action
  handleRoomList(roomListListener) {
    if (_socket != null) {
      _socket.emit(GET_ROOM_LIST);
      print('emitted room List');
      _socket.off(GET_ROOM_LIST);
      _socket.on(GET_ROOM_LIST, (roomData) {
        roomListListener(roomData);
      });
    }
  }

  emitLoadMessage(chatType,offset) {
    if (currentChatRoom != null) {
      var loadMsgData = {
        "room_key": currentChatRoom.roomName,
        "type": currentChatRoom.type,
        "user_id": socketUserData.sId,
        "offset":offset
      };
      _socket.emit(GET_MESSAGE_LIST, loadMsgData);
    } else {
      var loadMsgData = {
        "room_key": currentChatRoomKey,
        "type": chatType,
        "user_id": socketUserData.sId,
        "offset":offset
      };
      _socket.emit(GET_MESSAGE_LIST, loadMsgData);
    }
  }

  onLoadMessageListener(loadMessageHandler) {
    print('onLoadMessageListener : currentChatRoom');
    _socket.on(GET_MESSAGE_LIST, (messageList) {
      var d = UserChatMessageListModel.fromJson(messageList);
      currentChatRoomKey = d.roomKey;
      print('loadMessage:');
      print(messageList);
      loadMessageHandler(messageList);
    });
  }
  markThreadAsRead(roomKey){
    _socket.emit(MARK_THREAD_AS_READ,{
      "room_key": roomKey ?? currentChatRoomKey,
      "user_id": socketUserData.sId
    });
  }
  onNewMessageListener(newMessageHandler) {
    _socket.on(SEND_NEW_MESSAGE, (newMessage) {
      emitRoomList();
      newMessageHandler(newMessage);
    });
  }

  @action
  void joinPrivateUser(roomData) {
    currentChatRoom = roomData;
    var users = roomData.roomName.split('_');
    print('users split from room');
    print(users.toString());
    _socket.emit(JOIN_USER_PRIVATE_CHAT, {
      "type": roomData.type,
      "room_key": roomData.roomName,
      // userid of the user whom you want to chat
      "user_id": socketUserData.sId
      // mongodb userid of the loggedin user
    });
    _socket.on(GET_MESSAGE_LIST, (messageList) {
      print('loadMessage:');
      print(messageList);
      // loadMessageHandler(messageList);
    });
    _socket.on(JOIN_USER_PRIVATE_CHAT, (joinedUData) {
      joinedUserData = joinedUData;
      print('onJoinUserPrivateChat');
      print(joinedUserData);
    });
  }

  @action
  void joinNewPrivateUser(newUserData) {
    print('New User Create/Join Room');
    print(newUserData.toString());
    var udata = {
      "type": 'private',
      "sqlId": newUserData.userId,
      // userid of the user whom you want to chat
      "user_id": socketUserData.sId
      // mongodb userid of the loggedin user
    };
    _socket.emit(JOIN_USER_PRIVATE_CHAT, udata);
    _socket.on(GET_MESSAGE_LIST, (messageList) {
      print('loadMessage:');
      print(messageList);
      // loadMessageHandler(messageList);
    });
    _socket.on(JOIN_USER_PRIVATE_CHAT, (joinedUData) {
      joinedUserData = joinedUData;
      print('onJoinUserPrivateChat');
      print(joinedUserData);
    });
  }

  @action
  void sendMessage(textMessage, threadInfo, type, callback) {
    if(type == 'text') {
      String messageText = textMessage.trim();
      print(currentMessageList);
      print(currentChatRoom);
      print(messageText);
      if (messageText != '') {
        var msg = {
          // "_id": socketUserData.sId,
          "room_key": currentChatRoom.roomName,
          "message": messageText,
          "user_type": userData.user.roleId.toString() ?? '1',
          "message_type": "text",
          "senderUserId": socketUserData.sId,
          "files": [],
          "user": {
            "userSqlId": socketUserData.sqlId,
            "firstName": (socketUserData.firstName ?? ''),
            "lastName": (socketUserData.lastName ?? ''),
            "profile": socketUserData.profile
          }
        };
        _socket.emit('sendMessage', msg);
        callback();
      }
    }else{
      print(textMessage);
      var msg = {
        // "_id": socketUserData.sId,
        "room_key": currentChatRoom.roomName,
        "message": '',
        "user_type": userData.user.roleId.toString() ?? '1',
        "message_type": type,
        "senderUserId": socketUserData.sId,
        "files": [textMessage.data],
        "user": {
          "userSqlId": socketUserData.sqlId,
          "firstName": (socketUserData.firstName ?? ''),
          "lastName": (socketUserData.lastName ?? ''),
          "profile": socketUserData.profile
        }
      };
      _socket.emit('sendMessage', msg);
      callback();
    }
  }

  @ConnectionState.active
  void socketDisconnect() {
    if (isSocketConnected) {
      _socket.disconnect();
      isSocketConnected = false;
      print(_socket);
    }
  }
}
