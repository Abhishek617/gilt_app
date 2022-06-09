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
  int? id;
  String? type;
  String? brand;
  String? expiry;
  String? bankName;
  int? userId;
  String? customerId;
  String? customerPaymentProfileId;
  bool? isDefault;
  String? updatedAt;
  String? createdAt;

  PaymentCardDetails(
      {this.id,
      this.type,
      this.brand,
      this.expiry,
      this.bankName,
      this.userId,
      this.customerId,
      this.customerPaymentProfileId,
      this.isDefault,
      this.updatedAt,
      this.createdAt});

  PaymentCardDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    brand = json['brand'];
    expiry = json['expiry'];
    bankName = json['bankName'];
    userId = json['userId'];
    customerId = json['customerId'];
    customerPaymentProfileId = json['customerPaymentProfileId'];
    isDefault = json['isDefault'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['expiry'] = this.expiry;
    data['bankName'] = this.bankName;
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['customerPaymentProfileId'] = this.customerPaymentProfileId;
    data['isDefault'] = this.isDefault;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
