class OauthModal {
  bool? success;
  String? message;
  Data? data;

  OauthModal({this.success, this.message, this.data});

  OauthModal.fromJson(Map<String, dynamic> json) {
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
  String? refreshToken;

  Data({this.user, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  Null? phone;
  Null? profile;
  Null? aboutme;
  Null? address;
  Null? city;
  Null? state;
  Null? country;
  Null? zip;
  int? roleId;
  Null? deletedAt;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? authToken;

  User(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.password,
        this.phone,
        this.profile,
        this.aboutme,
        this.address,
        this.city,
        this.state,
        this.country,
        this.zip,
        this.roleId,
        this.deletedAt,
        this.isEmailVerified,
        this.isPhoneVerified,
        this.authToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    profile = json['profile'];
    aboutme = json['aboutme'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    roleId = json['role_id'];
    deletedAt = json['deleted_at'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['profile'] = this.profile;
    data['aboutme'] = this.aboutme;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['role_id'] = this.roleId;
    data['deleted_at'] = this.deletedAt;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['auth_token'] = this.authToken;
    return data;
  }
}
