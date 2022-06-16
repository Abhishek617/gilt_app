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
  String? brand;
  String? cardLastFourDigit;
  String? bankName;
  int? userId;
  String? customerId;
  String? customerPaymentProfileId;
  String? type;
  String? expiry;
  bool? isDefault;
  int? bankAccountNumLastSixDigit;
  int? routingNumberLastFourDigit;
  String? nameOnAccount;
  String? cardHolderName;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  PaymentCardDetails(
      {this.id,
      this.brand,
      this.cardLastFourDigit,
      this.bankName,
      this.userId,
      this.customerId,
      this.customerPaymentProfileId,
      this.type,
      this.expiry,
      this.isDefault,
      this.bankAccountNumLastSixDigit,
      this.routingNumberLastFourDigit,
      this.nameOnAccount,
      this.cardHolderName,
      this.createdAt,
      this.updatedAt,
      this.isSelected});

  PaymentCardDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    cardLastFourDigit = json['cardLastFourDigit'];
    bankName = json['bankName'];
    userId = json['userId'];
    customerId = json['customerId'];
    customerPaymentProfileId = json['customerPaymentProfileId'];
    type = json['type'];
    expiry = json['expiry'];
    isDefault = json['isDefault'];
    bankAccountNumLastSixDigit = json['bankAccountNumLastSixDigit'];
    routingNumberLastFourDigit = json['routingNumberLastFourDigit'];
    nameOnAccount = json['nameOnAccount'];
    cardHolderName = json['cardHolderName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isSelected = json['isSelected'] = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['cardLastFourDigit'] = this.cardLastFourDigit;
    data['bankName'] = this.bankName;
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['customerPaymentProfileId'] = this.customerPaymentProfileId;
    data['type'] = this.type;
    data['expiry'] = this.expiry;
    data['isDefault'] = this.isDefault;
    data['bankAccountNumLastSixDigit'] = this.bankAccountNumLastSixDigit;
    data['routingNumberLastFourDigit'] = this.routingNumberLastFourDigit;
    data['nameOnAccount'] = this.nameOnAccount;
    data['cardHolderName'] = this.cardHolderName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
