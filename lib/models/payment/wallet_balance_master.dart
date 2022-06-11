class WalletBalanceMaster {
  bool? success;
  String? message;
  WalletData? data;

  WalletBalanceMaster({this.success, this.message, this.data});

  WalletBalanceMaster.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new WalletData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class WalletData {
  int? id;
  int? walletBalance;
  int? walletBlockBalance;

  WalletData({this.id, this.walletBalance, this.walletBlockBalance});

  WalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletBalance = json['walletBalance'];
    walletBlockBalance = json['walletBlockBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['walletBalance'] = this.walletBalance;
    data['walletBlockBalance'] = this.walletBlockBalance;
    return data;
  }
}