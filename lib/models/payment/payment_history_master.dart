class PaymentHistoryMaster {
  bool? success;
  String? message;
  PaymentHistoryDetails? history;

  PaymentHistoryMaster({this.success, this.message, this.history});

  PaymentHistoryMaster.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    history =
        json['history'] != null ? new PaymentHistoryDetails.fromJson(json['history']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.history != null) {
      data['history'] = this.history!.toJson();
    }
    return data;
  }
}

class PaymentHistoryDetails {
  int? totalItems;
  List<PaymentHistoryModel>? listData;
  int? totalPages;
  int? currentPage;

  PaymentHistoryDetails({this.totalItems, this.listData, this.totalPages, this.currentPage});

  PaymentHistoryDetails.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['listData'] != null) {
      listData = <PaymentHistoryModel>[];
      json['listData'].forEach((v) {
        listData!.add(new PaymentHistoryModel.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.listData != null) {
      data['listData'] = this.listData!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class PaymentHistoryModel {
  PaymentHistoryModel();

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
