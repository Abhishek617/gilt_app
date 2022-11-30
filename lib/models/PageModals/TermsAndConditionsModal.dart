class TermsAndConditionsModal {
  bool? success;
  String? message;
  Data? data;

  TermsAndConditionsModal({this.success, this.message, this.data});

  TermsAndConditionsModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? title;
  List<TermsData>? data;

  Data({this.title, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['data'] != null) {
      data = <TermsData>[];
      json['data'].forEach((v) {
        data!.add(new TermsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TermsData {
  String? title;
  String? description;

  TermsData({this.title, this.description});

  TermsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
