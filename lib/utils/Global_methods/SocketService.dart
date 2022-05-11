import 'package:guilt_app/data/network/constants/endpoints.dart';
import 'package:guilt_app/data/repository.dart';
import 'package:guilt_app/di/components/service_locator.dart';
import 'package:guilt_app/stores/user/user_store.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late IO.Socket socket;
late var socketUserData;
final UserStore _userStore = UserStore(getIt<Repository>());
var userData = _userStore.Profile_data?.user;
var userFullName =
    (userData?.firstname ?? '') + ' ' + (userData?.lastname ?? '');

void initSocket() {
  print('Connecting to chat service');
  // String registrationToken = await getFCMToken();
  var aToken = _userStore.authToken;
  _userStore.getProfile();
  var userData = _userStore.Profile_data?.user;
  print(aToken);
  print(userData);
  if (aToken != null) {
    socket = IO.io(Endpoints.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'userName': userFullName,
      }
    });
    socket.io.options['extraHeaders'] = {
      'token': 'Bearer $aToken'
    }; // Update the extra headers.
    socket.connect();
    socket.onConnect((userData) {
      print('connected to websocket');
      socketUserData = userData;

      socket.emit('roomList');
    });
    socket.on('roomList', (message) {
      print(message);
    });
    socket.on('error', (message) {
      print('---------------Socket Error occurred--------------');
      print(message);
      // setState(() {
      //   MessagesModel.messages.add(message);
      // });
    });
  }
}

void joinChat(roomData, callback) {
  socket.emit('userJoinPrivate', {'phone': roomData.phone});
  socket.on('userJoinPrivate', callback);
}

void sendMessage(textMessage, callback) {
  String messageText = textMessage.trim();
  print(messageText);
  if (messageText != '') {
    var messagePost = {
      "room_key": "9558107350_9558107351",
      "senderUserId": userData?.id ?? '', //mongodb userid
      "content": messageText,
      "user_name": userFullName,
      "user_type": userData?.roleId ?? '1',
      "userSqlId": socketUserData.socId,
    };
    socket.emit('sendMessage', messagePost);
    callback();
  }
}

void socketDisconnect() {
  if(socket != null) {
    socket.disconnect();
  }
}
