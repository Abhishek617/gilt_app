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
  BusinessInfo? businessInfo;
  String? roomId;
  String? index;
  String? roomName;
  int? unreadMessageCount;
  List<Users>? users;
  EventInfo? eventInfo;

  Rooms(
      {this.sId,
        this.lastMessageAt,
        this.lastMessage,
        this.type,
        this.businessInfo,
        this.roomId,
        this.index,
        this.roomName,
        this.unreadMessageCount,
        this.users,
        this.eventInfo});

  Rooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lastMessageAt = json['last_message_at'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    type = json['type'];
    businessInfo = json['businessInfo'] != null
        ? new BusinessInfo.fromJson(json['businessInfo'])
        : null;
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
    eventInfo = json['eventInfo'] != null
        ? new EventInfo.fromJson(json['eventInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['last_message_at'] = this.lastMessageAt;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['type'] = this.type;
    if (this.businessInfo != null) {
      data['businessInfo'] = this.businessInfo!.toJson();
    }
    data['roomId'] = this.roomId;
    data['index'] = this.index;
    data['roomName'] = this.roomName;
    data['unreadMessageCount'] = this.unreadMessageCount;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.eventInfo != null) {
      data['eventInfo'] = this.eventInfo!.toJson();
    }
    return data;
  }
}

class LastMessage {
  String? messageType;
  String? message;
  String? senderUserId;
  String? username;
  String? userType;
  String? userSqlId;
  String? date;
  String? timestamp;

  LastMessage(
      {this.messageType,
        this.message,
        this.senderUserId,
        this.username,
        this.userType,
        this.userSqlId,
        this.date,
        this.timestamp});

  LastMessage.fromJson(Map<String, dynamic> json) {
    messageType = json['message_type'];
    message = json['message'];
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
    data['message'] = this.message;
    data['senderUserId'] = this.senderUserId;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['userSqlId'] = this.userSqlId;
    data['date'] = this.date;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class BusinessInfo {
  String? name;
  String? image;
  int? sqlId;
  String? sId;

  BusinessInfo({this.name, this.image, this.sqlId, this.sId});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    sqlId = json['sqlId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['sqlId'] = this.sqlId;
    data['_id'] = this.sId;
    return data;
  }
}

class Users {
  String? sId;
  String? firstName;
  String? lastName;
  int? sqlId;
  int? roleId;
  String? profile;
  bool? isActive;
  String? lastOnline;

  Users(
      {this.sId,
        this.firstName,
        this.lastName,
        this.sqlId,
        this.roleId,
        this.profile,
        this.isActive,
        this.lastOnline});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sqlId = json['sqlId'];
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
    data['sqlId'] = this.sqlId;
    data['roleId'] = this.roleId;
    data['profile'] = this.profile;
    data['isActive'] = this.isActive;
    data['lastOnline'] = this.lastOnline;
    return data;
  }
}

class EventInfo {
  String? name;
  String? image;
  String? hostedUsername;
  int? sqlId;
  String? sId;

  EventInfo({this.name, this.image, this.hostedUsername, this.sqlId, this.sId});

  EventInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    hostedUsername = json['hostedUsername'];
    sqlId = json['sqlId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['hostedUsername'] = this.hostedUsername;
    data['sqlId'] = this.sqlId;
    data['_id'] = this.sId;
    return data;
  }
}
