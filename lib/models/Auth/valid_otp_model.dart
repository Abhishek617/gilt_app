class ValidOtpModel {
  bool? success;
  String? emailPhone;
  String? message;

  ValidOtpModel({this.success, this.emailPhone, this.message});

  ValidOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    emailPhone = json['email_phone'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['email_phone'] = this.emailPhone;
    data['message'] = this.message;
    return data;
  }
}
