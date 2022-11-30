class OtpValidateModel {
  OtpValidateModel({
    required this.success,
    required this.message,
    required this.data,
  });
  late final bool success;
  late final String message;
  late final Data? data;

  OtpValidateModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    // data = Data.fromJson(json['data']);
    data = json['data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    if (this.data != null) {
      _data['data'] = this.data!.toJson();
    }
    return _data;
  }
}

class Data {
  Data({
    required this.user,
    required this.refreshToken,
  });
  late final User? user;
  late final String refreshToken;

  Data.fromJson(Map<String, dynamic> json){
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    // user = User.fromJson(json['user']);
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user!.toJson();
    _data['refreshToken'] = refreshToken;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    this.profile,
    this.aboutme,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zip,
    required this.roleId,
    this.deletedAt,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.authToken,
  });
  late final int id;
  late final String firstname;
  late final String lastname;
  late final String email;
  late final String password;
  late final String phone;
  late final Null profile;
  late final Null aboutme;
  late final Null address;
  late final Null city;
  late final Null state;
  late final Null country;
  late final Null zip;
  late final int roleId;
  late final Null deletedAt;
  late final bool isEmailVerified;
  late final bool isPhoneVerified;
  late final String authToken;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    profile = null;
    aboutme = null;
    address = null;
    city = null;
    state = null;
    country = null;
    zip = null;
    roleId = json['role_id'];
    deletedAt = null;
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['email'] = email;
    _data['password'] = password;
    _data['phone'] = phone;
    _data['profile'] = profile;
    _data['aboutme'] = aboutme;
    _data['address'] = address;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['zip'] = zip;
    _data['role_id'] = roleId;
    _data['deleted_at'] = deletedAt;
    _data['isEmailVerified'] = isEmailVerified;
    _data['isPhoneVerified'] = isPhoneVerified;
    _data['auth_token'] = authToken;
    return _data;
  }
}