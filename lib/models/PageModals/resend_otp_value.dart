class ResendOTPPageArgs {
  String email = '';
  String phone = '';


  ResendOTPPageArgs(
      {required this.email,
        required this.phone,
     });

  ResendOTPPageArgs.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;

    return data;
  }
}
