class RoomListModel {
  RoomData? roomData;

  RoomListModel({this.roomData});

  RoomListModel.fromJson(Map<String, dynamic> json) {
    roomData = json['roomData'] != null
        ? new RoomData.fromJson(json['roomData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomData != null) {
      data['roomData'] = this.roomData!.toJson();
    }
    return data;
  }
}

class RoomData {
  List<Rooms>? rooms;
  int? offset;

  RoomData({this.rooms, this.offset});

  RoomData.fromJson(Map<String, dynamic> json) {
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    return data;
  }
}

class Rooms {
  String? sId;
  String? lastMessageAt;
  LastMessage? lastMessage;
  String? type;
  String? roomId;
  String? index;
  String? roomName;
  int? unreadMessageCount;
  List<Users>? users;

  Rooms(
      {this.sId,
        this.lastMessageAt,
        this.lastMessage,
        this.type,
        this.roomId,
        this.index,
        this.roomName,
        this.unreadMessageCount,
        this.users});

  Rooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lastMessageAt = json['last_message_at'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    type = json['type'];
    roomId = json['roomId'];
    index = json['index'];
    roomName = json['roomName'];
    unreadMessageCount = json['unreadMessageCount'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['last_message_at'] = this.lastMessageAt;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['type'] = this.type;
    data['roomId'] = this.roomId;
    data['index'] = this.index;
    data['roomName'] = this.roomName;
    data['unreadMessageCount'] = this.unreadMessageCount;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastMessage {
  String? messageType;
  String? content;
  String? senderUserId;
  String? username;
  int? userType;
  int? userSqlId;
  String? date;
  String? timestamp;

  LastMessage(
      {this.messageType,
        this.content,
        this.senderUserId,
        this.username,
        this.userType,
        this.userSqlId,
        this.date,
        this.timestamp});

  LastMessage.fromJson(Map<String, dynamic> json) {
    messageType = json['message_type'];
    content = json['content'];
    senderUserId = json['senderUserId'];
    username = json['username'];
    userType = json['user_type'];
    userSqlId = json['userSqlId'];
    date = json['date'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_type'] = this.messageType;
    data['content'] = this.content;
    data['senderUserId'] = this.senderUserId;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['userSqlId'] = this.userSqlId;
    data['date'] = this.date;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Users {
  String? sId;
  String? firstName;
  String? lastName;
  int? roleId;
  String? profile;
  bool? isActive;
  String? lastOnline;

  Users(
      {this.sId,
        this.firstName,
        this.lastName,
        this.roleId,
        this.profile,
        this.isActive,
        this.lastOnline});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    roleId = json['roleId'];
    profile = json['profile'];
    isActive = json['isActive'];
    lastOnline = json['lastOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['roleId'] = this.roleId;
    data['profile'] = this.profile;
    data['isActive'] = this.isActive;
    data['lastOnline'] = this.lastOnline;
    return data;
  }
}
