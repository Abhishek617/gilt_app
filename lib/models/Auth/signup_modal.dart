import 'package:guilt_app/models/Auth/error_master.dart';

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
  List<ErrorResponse>? error;

  SignUpResponseModal({this.success, this.message, this.data, this.error});

  SignUpResponseModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = <ErrorResponse>[];
      json['error'].forEach((v) {
        error!.add(new ErrorResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  User? user;
  String? refreshToken;

  Data({this.user, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) user = User.fromJson(json['user']);
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['refreshToken'] = this.refreshToken;
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
  int? roleId;
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
    roleId =
        json['role_id'] != null ? int.parse(json['role_id'].toString()) : 1;
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
