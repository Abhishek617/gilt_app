class PayToUserRequest {
  int? customerProfileId;
  int? paymentProfile;
  int? amount;
  int? walletAmount;
  int? toUserId;
  String? paymentMethod;
  int? paymentReqId;
  int? businessId;

  PayToUserRequest(
      {this.customerProfileId,
        this.paymentProfile,
        this.amount,
        this.walletAmount,
        this.toUserId,
        this.paymentMethod,
        this.paymentReqId, this.businessId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerProfileId'] = this.customerProfileId;
    data['paymentProfile'] = this.paymentProfile;
    data['amount'] = this.amount;
    data['walletAmount'] = this.walletAmount;
    data['toUserId'] = this.toUserId;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentReqId'] = this.paymentReqId;
    data['businessId'] = this.businessId;
    return data;
  }
}