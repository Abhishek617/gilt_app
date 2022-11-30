class SocketUserModel {
  String? sId;
  String? firstName;
  String? lastName;
  int? sqlId;
  String? profile;
  bool? isActive;
  String? lastOnline;

  SocketUserModel(
      {this.sId,
        this.firstName,
        this.lastName,
        this.sqlId,
        this.profile,
        this.isActive,
        this.lastOnline});

  SocketUserModel.fromJson(Map<String, dynamic> json) {
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
