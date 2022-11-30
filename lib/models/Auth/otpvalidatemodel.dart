import '../Auth/signup_modal.dart';

class OtpValidateModel {
  OtpValidateModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  OtpValidateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null)
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    if (this.data != null) {
      _data['data'] = this.data!.toJson();
    }
    return _data;
  }
}
