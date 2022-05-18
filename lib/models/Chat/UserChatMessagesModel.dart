class UserChatMessageListModel {
  List<MessageObj>? messages;
  int? offset;
  ThreadUserInfo? threadUserInfo;
  String? roomKey;

  UserChatMessageListModel(
      {this.messages, this.offset, this.threadUserInfo, this.roomKey});

  UserChatMessageListModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <MessageObj>[];
      json['messages'].forEach((v) {
        messages!.add(new MessageObj.fromJson(v));
      });
    }
    offset = json['offset'];
    threadUserInfo = json['threadUserInfo'] != null
        ? new ThreadUserInfo.fromJson(json['threadUserInfo'])
        : null;
    roomKey = json['room_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    if (this.threadUserInfo != null) {
      data['threadUserInfo'] = this.threadUserInfo!.toJson();
    }
    data['room_key'] = this.roomKey;
    return data;
  }
}

class MessageObj {
  String? sId;
  String? roomKey;
  String? userType;
  String? messageType;
  String? createdAt;
  List<Files>? files;
  User? user;
  String? message;

  MessageObj(
      {this.sId,
        this.roomKey,
        this.userType,
        this.messageType,
        this.createdAt,
        this.files,
        this.user,
        this.message});

  MessageObj.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomKey = json['room_key'];
    userType = json['user_type'];
    messageType = json['message_type'];
    createdAt = json['created_at'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['room_key'] = this.roomKey;
    data['user_type'] = this.userType;
    data['message_type'] = this.messageType;
    data['created_at'] = this.createdAt;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Files {
  String? originalFileName;
  String? fileName;
  String? contentType;
  int? size;

  Files({this.originalFileName, this.fileName, this.contentType, this.size});

  Files.fromJson(Map<String, dynamic> json) {
    originalFileName = json['originalFileName'];
    fileName = json['fileName'];
    contentType = json['contentType'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalFileName'] = this.originalFileName;
    data['fileName'] = this.fileName;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? profile;

  User({this.firstName, this.lastName, this.profile});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profile'] = this.profile;
    return data;
  }
}

class ThreadUserInfo {
  String? sId;
  String? firstName;
  String? lastName;
  int? sqlId;
  String? profile;
  bool? isActive;
  String? lastOnline;

  ThreadUserInfo(
      {this.sId,
        this.firstName,
        this.lastName,
        this.sqlId,
        this.profile,
        this.isActive,
        this.lastOnline});

  ThreadUserInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sqlId = json['sqlId'];
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
    data['profile'] = this.profile;
    data['isActive'] = this.isActive;
    data['lastOnline'] = this.lastOnline;
    return data;
  }
}
