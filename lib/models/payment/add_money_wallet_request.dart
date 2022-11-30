class AddMoneyToWalletRequest {
  int? customerProfileId;
  int? paymentProfile;
  double? amount;
  String? paymentMethod;

  AddMoneyToWalletRequest(
      {this.customerProfileId,
        this.paymentProfile,
        this.amount,
        this.paymentMethod});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerProfileId'] = this.customerProfileId;
    data['paymentProfile'] = this.paymentProfile;
    data['amount'] = this.amount;
    data['paymentMethod'] = this.paymentMethod;
    return data;
  }
}