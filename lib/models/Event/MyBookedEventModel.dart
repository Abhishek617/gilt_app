import 'EventDetailResponseModel.dart';

class MyBookedEventModel {
  bool? success;
  String? message;
  Events? events;

  MyBookedEventModel({this.success, this.message, this.events});

  MyBookedEventModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    events =
    json['events'] != null ? new Events.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.events != null) {
      data['events'] = this.events!.toJson();
    }
    return data;
  }
}

class Events {
  int? totalItems;
  List<Event>? listData;
  int? totalPages;
  int? currentPage;

  Events({this.totalItems, this.listData, this.totalPages, this.currentPage});

  Events.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['listData'] != null) {
      listData = <Event>[];
      json['listData'].forEach((v) {
        listData!.add(new Event.fromJson(v));
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

