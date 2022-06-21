class UpdateProfileRequestModal {
  UpdateProfileRequestModal({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.profile,
    required this.aboutme,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zip,
  });

  late String email;
  late String firstname;
  late String lastname;
  late String phone;
  late dynamic profile;
  late String aboutme;
  late String address;
  late String city;
  late String state;
  late String country;
  late String zip;

  UpdateProfileRequestModal.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    profile = json['profile'];
    aboutme = json['aboutme'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['phone'] = phone;
    _data['profile'] = profile;
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

  late bool success;
  late User user;
  late String refreshToken;

  UpdateProfileResponseModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = User.fromJson(json['user']);
    refreshToken = json['refreshToken']?? '';
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
    required this.profile,
    required this.aboutme,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zip,
    required this.roleId,
    required this.deletedAt,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.authToken,
  });

  late int id;
  late String firstname;
  late String lastname;
  late String email;
  late String password;
  late String phone;
  late dynamic profile;
  late String aboutme;
  late String address;
  late String city;
  late String state;
  late String country;
  late int zip;
  late int roleId;
  late String deletedAt;
  late bool isEmailVerified;
  late bool isPhoneVerified;
  late String authToken;

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
    deletedAt = json['deleted_at'] ?? '';
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
