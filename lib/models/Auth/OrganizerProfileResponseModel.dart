class OrganizerProfileResponseModel {
  bool? success;
  OrganizerUser? user;

  OrganizerProfileResponseModel({this.success, this.user});

  OrganizerProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new OrganizerUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class OrganizerUser {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? phone;
  String? profile;
  String? aboutme;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zip;
  int? roleId;
  String? deletedAt;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? authToken;
  String? customerProfileId;

  OrganizerUser(
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
        this.authToken,
        this.customerProfileId});

  OrganizerUser.fromJson(Map<String, dynamic> json) {
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
    customerProfileId = json['customerProfileId'];
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
    data['customerProfileId'] = this.customerProfileId;
    return data;
  }
}

