
class Valid_Otp_Model {
  String? emailPhone;
  int? otp;

  Valid_Otp_Model({this.emailPhone, this.otp});

  Valid_Otp_Model.fromJson(Map<String, dynamic> json) {
    emailPhone = json['email_phone'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_phone'] = this.emailPhone;
    data['otp'] = this.otp;
    return data;
  }
}