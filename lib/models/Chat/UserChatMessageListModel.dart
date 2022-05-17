class CatchSentMessageModel {
  MessageData? data;

  CatchSentMessageModel({this.data});

  CatchSentMessageModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MessageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MessageData {
  String? roomKey;
  String? senderUserId;
  String? message;
  String? username;
  String? userType;
  int? userSqlId;
  String? messageType;
  String? sId;

  MessageData(
      {this.roomKey,
        this.senderUserId,
        this.message,
        this.username,
        this.userType,
        this.userSqlId,
        this.messageType,
        this.sId});

  MessageData.fromJson(Map<String, dynamic> json) {
    roomKey = json['room_key'];
    senderUserId = json['senderUserId'];
    message = json['message'];
    username = json['username'];
    userType = json['user_type'];
    userSqlId = json['userSqlId'];
    messageType = json['message_type'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_key'] = this.roomKey;
    data['senderUserId'] = this.senderUserId;
    data['message'] = this.message;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['userSqlId'] = this.userSqlId;
    data['message_type'] = this.messageType;
    data['_id'] = this.sId;
    return data;
  }
}