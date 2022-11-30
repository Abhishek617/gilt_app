class UpdateProfileRequestModal {
  UpdateProfileRequestModal({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.aboutme,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zip,
  });
  late final String email;
  late final String firstname;
  late final String lastname;
  late final String phone;
  late final String aboutme;
  late final String address;
  late final String city;
  late final String state;
  late final String country;
  late final int zip;

  UpdateProfileRequestModal.fromJson(Map<String, dynamic> json){
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    aboutme = json['aboutme'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['phone'] = phone;
    _data['aboutme'] = aboutme;
    _data['address'] = address;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['zip'] = zip;
    return _data;
  }
}



class UpdateProfileResponseModal {
  UpdateProfileResponseModal({
    required this.success,
    required this.user,
    required this.refreshToken,
  });
  late final bool success;
  late final User user;
  late final String refreshToken;

  UpdateProfileResponseModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    user = User.fromJson(json['user']);
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['user'] = user.toJson();
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
    required this.aboutme,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zip,
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
  late final String aboutme;
  late final String address;
  late final String city;
  late final String state;
  late final String country;
  late final int zip;
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
    aboutme = json['aboutme'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
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

