import 'package:guilt_app/models/Chat/UserChatMessagesModel.dart';

class CatchSentMessageModel {
  MessageObj? data;

  CatchSentMessageModel({this.data});

  CatchSentMessageModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MessageObj.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
