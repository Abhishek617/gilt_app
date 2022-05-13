class UserChatMessagesModel {
  List<Messages>? messages;
  int? offset;
  ThreadUserInfo? threadUserInfo;

  UserChatMessagesModel({this.messages, this.offset, this.threadUserInfo});

  UserChatMessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    offset = json['offset'];
    threadUserInfo = json['threadUserInfo'] != null
        ? new ThreadUserInfo.fromJson(json['threadUserInfo'])
        : null;
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
    return data;
  }
}

class Messages {
  String? sId;
  String? roomKey;
  String? username;
  String? userType;
  String? messageType;
  List<Files>? files;
  String? content;

  Messages(
      {this.sId,
        this.roomKey,
        this.username,
        this.userType,
        this.messageType,
        this.files,
        this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomKey = json['room_key'];
    username = json['username'];
    userType = json['user_type'];
    messageType = json['message_type'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['room_key'] = this.roomKey;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['message_type'] = this.messageType;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['content'] = this.content;
    return data;
  }
}

class Files {
  String? originalFileName;
  String? fileName;
  String? contentType;
  int? size;
  String? sId;
  String? url;

  Files(
      {this.originalFileName,
        this.fileName,
        this.contentType,
        this.size,
        this.sId,
        this.url});

  Files.fromJson(Map<String, dynamic> json) {
    originalFileName = json['originalFileName'];
    fileName = json['fileName'];
    contentType = json['contentType'];
    size = json['size'];
    sId = json['_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalFileName'] = this.originalFileName;
    data['fileName'] = this.fileName;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    data['_id'] = this.sId;
    data['url'] = this.url;
    return data;
  }
}

class ThreadUserInfo {
  String? sId;
  String? firstName;
  String? lastName;
  int? sqlId;
  bool? isActive;
  String? lastOnline;
  String? profile;

  ThreadUserInfo(
      {this.sId,
        this.firstName,
        this.lastName,
        this.sqlId,
        this.isActive,
        this.lastOnline,
        this.profile});

  ThreadUserInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sqlId = json['sqlId'];
    isActive = json['isActive'];
    lastOnline = json['lastOnline'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['sqlId'] = this.sqlId;
    data['isActive'] = this.isActive;
    data['lastOnline'] = this.lastOnline;
    data['profile'] = this.profile;
    return data;
  }
}
