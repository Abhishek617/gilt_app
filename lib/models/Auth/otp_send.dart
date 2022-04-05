class OtpSendModel {
  bool? success;
  String? emailPhone;
  String? message;
  int? otp;

  OtpSendModel({this.success, this.emailPhone, this.message, this.otp});

  OtpSendModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    emailPhone = json['email_phone'];
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['email_phone'] = this.emailPhone;
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}

