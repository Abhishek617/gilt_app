class PaymentCardMaster {
  bool? success;
  String? message;
  List<PaymentCardDetails>? list;

  PaymentCardMaster({this.success, this.message, this.list});

  PaymentCardMaster.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['list'] != null) {
      list = <PaymentCardDetails>[];
      json['list'].forEach((v) {
        list!.add(new PaymentCardDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentCardDetails {
  PaymentCardDetails();

  PaymentCardDetails.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
