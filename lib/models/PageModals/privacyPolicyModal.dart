class PrivacyPolicyModal {
  bool? success;
  String? message;
  Data? data;

  PrivacyPolicyModal({this.success, this.message, this.data});

  PrivacyPolicyModal.fromJson(Map<String, dynamic> json) {
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
  List<PolicyData>? data;

  Data({this.title, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['data'] != null) {
      data = <PolicyData>[];
      json['data'].forEach((v) {
        data!.add(new PolicyData.fromJson(v));
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

class PolicyData {
  String? title;
  String? description;
  List<Subdescription>? subdescription;

  PolicyData({this.title, this.description, this.subdescription});

  PolicyData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    if (json['subdescription'] != null) {
      subdescription = <Subdescription>[];
      json['subdescription'].forEach((v) {
        subdescription!.add(new Subdescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.subdescription != null) {
      data['subdescription'] =
          this.subdescription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subdescription {
  String? label;

  Subdescription({this.label});

  Subdescription.fromJson(Map<String, dynamic> json) {
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    return data;
  }
}
