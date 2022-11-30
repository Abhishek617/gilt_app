import 'package:guilt_app/models/Business/BusinessDetailResponseModel.dart';

class SearchBusinessModel {
  bool? success;
  String? message;
  List<Business>? data;

  SearchBusinessModel({this.success, this.message, this.data});

  SearchBusinessModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Business>[];
      json['data'].forEach((v) {
        data!.add(new Business.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}