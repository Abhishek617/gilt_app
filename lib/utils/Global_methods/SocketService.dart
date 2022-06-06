import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/sharedpref/constants/preferences.dart';
import 'package:guilt_app/models/Auth/profile_modal.dart';
import 'package:guilt_app/models/Business/BusinessDetailResponseModel.dart';
import 'package:guilt_app/models/Chat/SocketUserModel.dart';
import 'package:guilt_app/models/Chat/UserChatMessagesModel.dart';
import 'package:guilt_app/models/Chat/roomListModel.dart';
import 'package:guilt_app/models/Event/EventDetailResponseModel.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketUtils {
  late IO.Socket _socket;
  late SocketUserModel socketUserData;
  bool isSocketConnected = false;

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
          print('connected to web socket');
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
              currentChatRoomKey = currentMessageList.roomKey;
              print(response);
            });
          }
        });
      }
    } else {
      initSocket();
    }
  }

  emitJoinBusinessChat(Business businessData) {
    if (isSocketConnected) {
      getUserData((data) {
        print('socketUserData');
        print(data);
        if (data != null) {
          socketUserData = data;
          var bData = {
            "id": businessData.id,
            // business Id
            "user_id": socketUserData.sId,
            // logged in userid
            "type": "business",
            // pass businessInfo only when new thread created otherwise when redirecting from thread to thread detail its not needed
            "businessInfo": {
              "name": businessData.name,
              "image": businessData.businessPhotos!.length > 0
                  ? businessData.businessPhotos![0].name
                  : '',
              "hostedUsername": (businessData.admin?.firstname ?? '') +
                  ' ' +
                  (businessData.admin?.lastname ?? ''),
              "sqlId": businessData.id
            },
            "room_key": "bs_" +
                businessData.id.toString() +
                "_" +
                businessData.createdBy.toString() +
                "_" +
                socketUserData.sqlId.toString()
            // room_key: bs_businessSQLID_businessHostSQLID_otherPersonWhoJoinSQLID
          };
          print('bData');
          print(bData);
          _socket.emit(JOIN_USER_BUSINESS_CHAT, bData);
          _socket.off(GET_MESSAGE_LIST);
          _socket.on(JOIN_USER_BUSINESS_CHAT, (response) {
            print(response);
          });
          _socket.on(GET_MESSAGE_LIST, (response) {
            currentMessageList = UserChatMessageListModel.fromJson(response);
            currentChatRoomKey = currentMessageList.roomKey ?? currentMessageList?.roomData?.roomKey;
            print(response);
          });
        }
      });
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
      _socket.emit(GET_ROOM_LIST);
      print('emitted room List');
      _socket.off(GET_ROOM_LIST);
      _socket.on(GET_ROOM_LIST, (roomData) {
        roomListListener(roomData);
      });
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
        "type": chatType,
        "user_id": socketUserData.sId,
        "offset": offset,
        "limit": 20,
      };
      if (chatType == 'private') {
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
        // mongodb userid of the logged in user
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
      var uData = {
        "type": 'private',
        "sqlId": newUserData.userId,
        // userid of the user whom you want to chat
        "user_id": socketUserData.sId
        // mongodb userid of the logged in user
      };
      _socket.emit(JOIN_USER_PRIVATE_CHAT, uData);
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
        if (messageText  != '') {
          var msg = {
            // "_id": socketUserData.sId,
            "room_key": roomKey ?? currentChatRoomKey,
            "message": messageText,
            "user_type": userData.user.roleId.toString(),
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
          "user_type": userData.user.roleId.toString(),
          "message_type": type,
          "senderUserId": socketUserData.sId,
          "files": [
            {
              "originalFileName": iData.originalname,
              "fileName": 'GUILT_' + iData.originalname,
              "contentType": iData.contentType,
              "size": iData.size
            }
          ],
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
