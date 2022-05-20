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
import 'package:guilt_app/models/Event/EventDetailResponseModel.dart';
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
  static const String GET_MESSAGE_LIST_EMIT = 'loadMessages';
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
    if (isSocketConnected) {
      _socket.emit(JOIN_USER_PRIVATE_CHAT, {'phone': roomData.phone});
      _socket.on(JOIN_USER_PRIVATE_CHAT, (response) {
        callback(response);
      });
    } else {
      initSocket();
    }
  }

  emitJoinEventChat(EventDetailsResponseModel eventData) {
    if (isSocketConnected) {
      var event = eventData.event;
      if (event != null) {
        getUserData((data) {
          print('socketUserData');
          print(data);
          if (data != null) {
            socketUserData = data;
            var eData = {
              "eventName": event.name,
              "id": event.id,
              "user_id": socketUserData.sId,
              "type": "event",
              "eventInfo": {
                "name": event.name,
                "image": event.eventImages?.length == 0
                    ? "https://guiltapp.s3.amazonaws.com/profile/1648029484683bird-thumbnail.jpg"
                    : event.eventImages?[0],
                "hostedUsername":
                    (event.organizer?.firstname.toString() ?? '') +
                        ' ' +
                        (event.organizer?.lastname.toString() ?? ''),
                "sqlId": event.id
              }
            };
            print('eData');
            print(eData);
            _socket.emit(JOIN_USER_EVENT_CHAT, eData);
            _socket.off(GET_MESSAGE_LIST);
            _socket.on(GET_MESSAGE_LIST, (response) {
              currentMessageList = UserChatMessageListModel.fromJson(response);
              currentChatRoomKey = currentMessageList.roomData['roomKey'];
              print(response);
            });
          }
        });
      }
    } else {
      initSocket();
    }
  }

  joinEventUser(Rooms eventRoomData) {
    if (isSocketConnected) {
      var event = eventRoomData;
      if (event != null) {
        getUserData((data) {
          print('socketUserData');
          print(data);
          if (data != null) {
            socketUserData = data;
            var eData = {
              "eventName": event.eventInfo?.name,
              "id": socketUserData.sqlId,
              "user_id": socketUserData.sId,
              "type": "event",
              "eventInfo": {
                "name": event.eventInfo?.name,
                "image": event.eventInfo?.image ??
                    "https://guiltapp.s3.amazonaws.com/profile/1648029484683bird-thumbnail.jpg",
                "hostedUsername": event.eventInfo?.hostedUsername,
                "sqlId": event.eventInfo?.sqlId
              }
            };
            print(eData);
            _socket.emit(JOIN_USER_EVENT_CHAT, eData);
            _socket.off(GET_MESSAGE_LIST);
            _socket.on(GET_MESSAGE_LIST, (response) {
              currentMessageList = response;
              print(response);
            });
          }
        });
      }
    } else {
      initSocket();
    }
  }

  getUserData(userDataHandler) {
    if (isSocketConnected) {
      _socket.emit(GET_USER_DATA);
      _socket.on(GET_USER_DATA, (response) {
        print('SocketUserData:');
        print(response);
        var uD = SocketUserModel.fromJson(response);
        userDataHandler(uD);
      });
    } else {
      initSocket();
    }
  }

  setOnMessageBackFromServer(Function onMessageBackFromServer) {
    if (isSocketConnected) {
      _socket.on(SEND_NEW_MESSAGE, (data) {
        onMessageBackFromServer(data);
      });
    } else {
      initSocket();
    }
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
    if (isSocketConnected) {
      _socket.emit(GET_ROOM_LIST);
    } else {
      initSocket();
    }
  }

  @action
  handleRoomList(roomListListener) {
    if (isSocketConnected) {
      if (_socket != null) {
        _socket.emit(GET_ROOM_LIST);
        print('emitted room List');
        _socket.off(GET_ROOM_LIST);
        _socket.on(GET_ROOM_LIST, (roomData) {
          roomListListener(roomData);
        });
      }
    } else {
      initSocket();
    }
  }

  emitLoadMessage(chatType, offset) {
    if (isSocketConnected) {
      print('loadMessage Offset : ' + offset.toString());
      var loadMsgData = {
        "room_key": (currentChatRoom != null)
            ? currentChatRoom.roomName
            : currentChatRoomKey,
        "type": currentChatRoom.type,
        "user_id": socketUserData.sId,
        "offset": offset,
        "limit": 20,
      };
      if (currentChatRoom.type == 'private') {
        loadMsgData['other_user_id'] = currentChatRoom.users[0].sqlId;
      }
      print('LoadMessage Emit Data : ' + loadMsgData.toString());
      _socket.emit(GET_MESSAGE_LIST_EMIT, loadMsgData);
    } else {
      initSocket();
    }
  }

  onLoadMessageListener(loadMessageHandler) {
    if (isSocketConnected) {
      print('onLoadMessageListener : currentChatRoom');
      //_socket.off(GET_MESSAGE_LIST);
      _socket.on(GET_MESSAGE_LIST, (messageList) {
        currentMessageList = messageList;
        var d = UserChatMessageListModel.fromJson(messageList);
        currentChatRoomKey =
            d.roomKey == null ? d.roomData?.roomKey : d.roomKey;
        //currentChatRoomKey = d.roomKey;
        print('loadMessage:');
        print(messageList);
        loadMessageHandler(messageList);
      });
    } else {
      initSocket();
    }
  }

  markThreadAsRead(roomKey) {
    if (isSocketConnected) {
      _socket.emit(MARK_THREAD_AS_READ, {
        "room_key": roomKey ?? currentChatRoomKey,
        "user_id": socketUserData.sId
      });
    } else {
      initSocket();
    }
  }

  onNewMessageListener(newMessageHandler) {
    if (isSocketConnected) {
      _socket.off(SEND_NEW_MESSAGE);
      _socket.on(SEND_NEW_MESSAGE, (newMessage) {
        emitRoomList();
        newMessageHandler(newMessage);
      });
    } else {
      initSocket();
    }
  }

  @action
  void joinPrivateUser(roomData) {
    if (isSocketConnected) {
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
      _socket.off(GET_MESSAGE_LIST);
      _socket.on(GET_MESSAGE_LIST, (messageList) {
        print('loadMessage:');
        print(messageList);
        currentMessageList = messageList;
        // loadMessageHandler(messageList);
      });
      _socket.on(JOIN_USER_PRIVATE_CHAT, (joinedUData) {
        joinedUserData = joinedUData;
        print('onJoinUserPrivateChat');
        print(joinedUserData);
      });
    } else {
      initSocket();
    }
  }

  @action
  void joinNewPrivateUser(newUserData) {
    if (isSocketConnected) {
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
      _socket.off(GET_MESSAGE_LIST);
      _socket.on(GET_MESSAGE_LIST, (messageList) {
        print('loadMessage:');
        print(messageList);
        currentChatRoomKey = messageList.roomKey;
        currentMessageList = messageList;
        // loadMessageHandler(messageList);
      });
      _socket.on(JOIN_USER_PRIVATE_CHAT, (joinedUData) {
        joinedUserData = joinedUData;
        print('onJoinUserPrivateChat');
        print(joinedUserData);
      });
    } else {
      initSocket();
    }
  }

  @action
  void sendMessage(textMessage, roomKey, type, callback) {
    if (isSocketConnected) {
      if (type == 'text') {
        String messageText = textMessage.trim();
        print(currentMessageList);
        print(currentChatRoom);
        print(messageText);
        if (messageText != '') {
          var msg = {
            // "_id": socketUserData.sId,
            "room_key": roomKey ?? currentChatRoomKey,
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
      } else {
        print(textMessage);
        var iData = textMessage.data[0];
        var msg = {
          // "_id": socketUserData.sId,
          "room_key": currentChatRoom.roomName,
          "message": iData.location,
          "user_type": userData.user.roleId.toString() ?? '1',
          "message_type": type,
          "senderUserId": socketUserData.sId,
          "files": [{
            "originalFileName": iData.originalname,
            "fileName": 'GUILT_' + iData.originalname,
            "contentType": iData.contentType,
            "size": iData.size
          }],
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
    } else {
      initSocket();
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
