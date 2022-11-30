class Feedback_add_Model {
  bool? success;
  String? message;

  Feedback_add_Model({this.success, this.message});

  Feedback_add_Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}