import 'package:guilt_app/models/Chat/UserChatMessagesModel.dart';

class EventLoadMessageListModel {
  List<MessageObj>? messages;
  int? offset;
  RoomData? roomData;

  EventLoadMessageListModel({this.messages, this.offset, this.roomData});

  EventLoadMessageListModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <MessageObj>[];
      json['messages'].forEach((v) {
        messages!.add(new MessageObj.fromJson(v));
      });
    }
    offset = json['offset'];
    roomData = json['roomData'] != null
        ? new RoomData.fromJson(json['roomData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    if (this.roomData != null) {
      data['roomData'] = this.roomData!.toJson();
    }
    return data;
  }
}

class RoomData {
  String? name;
  String? image;
  String? hostedUsername;
  int? sqlId;

  RoomData({this.name, this.image, this.hostedUsername, this.sqlId});

  RoomData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    hostedUsername = json['hostedUsername'];
    sqlId = json['sqlId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['hostedUsername'] = this.hostedUsername;
    data['sqlId'] = this.sqlId;
    return data;
  }
}
