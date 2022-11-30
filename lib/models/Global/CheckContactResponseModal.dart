class CheckContactResponse {
  bool? success;
  String? message;
  List<AppContact>? contact;

  CheckContactResponse({this.success, this.message, this.contact});

  CheckContactResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['contact'] != null) {
      contact = <AppContact>[];
      json['contact'].forEach((v) {
        contact!.add(new AppContact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.contact != null) {
      data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppContact {
  String? phone;
  int? isExist;
  int? userId;
  String? profile;

  AppContact({this.phone, this.isExist, this.userId, this.profile});

  AppContact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    isExist = json['is_exist'];
    userId = json['user_id'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['is_exist'] = this.isExist;
    data['user_id'] = this.userId;
    data['profile'] = this.profile;
    return data;
  }
}
