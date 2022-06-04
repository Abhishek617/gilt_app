class PaymentMaster {
  bool? success;
  String? message;
  PaymentRequestData? paymentData;

  PaymentMaster({this.success, this.message, this.paymentData});

  PaymentMaster.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    paymentData = json['paymentData'] != null
        ? new PaymentRequestData.fromJson(json['paymentData'])
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

class PaymentRequestData {
  String? status;
  int? id;
  int? toUser;
  int? amount;
  int? businessId;
  String? remarks;
  int? fromUser;
  String? updatedAt;
  String? createdAt;

  PaymentRequestData(
      {this.status,
        this.id,
        this.toUser,
        this.amount,
        this.businessId,
        this.remarks,
        this.fromUser,
        this.updatedAt,
        this.createdAt});

  PaymentRequestData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    toUser = json['toUser'];
    amount = json['amount'];
    businessId = json['businessId'];
    remarks = json['remarks'];
    fromUser = json['fromUser'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['toUser'] = this.toUser;
    data['amount'] = this.amount;
    data['businessId'] = this.businessId;
    data['remarks'] = this.remarks;
    data['fromUser'] = this.fromUser;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}