class SignUpRequestModal {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? password;
  String? roleId;

  SignUpRequestModal(
      {this.firstname,
        this.lastname,
        this.email,
        this.phone,
        this.password,
        this.roleId});

  SignUpRequestModal.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role_id'] = this.roleId;
    return data;
  }
}

class SignUpResponseModal {
  bool? success;
  String? message;
  Data? data;

  SignUpResponseModal({this.success, this.message, this.data});

  SignUpResponseModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  bool? isEmailVerified;
  bool? isPhoneVerified;
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? password;
  String? roleId;
  String? authToken;

  User(
      {this.isEmailVerified,
        this.isPhoneVerified,
        this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.phone,
        this.password,
        this.roleId,
        this.authToken});

  User.fromJson(Map<String, dynamic> json) {
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['role_id'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['role_id'] = this.roleId;
    data['auth_token'] = this.authToken;
    return data;
  }
}
