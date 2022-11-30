class FaqModel {
  bool? success;
  String? message;
  Data? data;

  FaqModel({this.success, this.message, this.data});

  FaqModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionData>? data;

  Data({this.title, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['data'] != null) {
      data = <QuestionData>[];
      json['data'].forEach((v) {
        data!.add(new QuestionData.fromJson(v));
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

class QuestionData {
  String? question;
  String? answer;

  QuestionData({this.question, this.answer});

  QuestionData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
