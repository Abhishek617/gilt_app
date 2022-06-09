import 'package:guilt_app/models/payment/payment_card_master.dart';

class AddPaymentMaster {
  bool? success;
  String? message;
  PaymentCardDetails? paymentData;

  AddPaymentMaster({this.success, this.message, this.paymentData});

  AddPaymentMaster.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    paymentData = json['paymentData'] != null
        ? new PaymentCardDetails.fromJson(json['paymentData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.paymentData != null) {
      data['paymentData'] = this.paymentData!.toJson();
    }
    return data;
  }
}
