class FeedbackListModel {
  bool? success;
  String? message;
  List<EventFeedbacks>? eventFeedbacks;

  FeedbackListModel({this.success, this.message, this.eventFeedbacks});

  FeedbackListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['eventFeedbacks'] != null) {
      eventFeedbacks = <EventFeedbacks>[];
      json['eventFeedbacks'].forEach((v) {
        eventFeedbacks!.add(new EventFeedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.eventFeedbacks != null) {
      data['eventFeedbacks'] =
          this.eventFeedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventFeedbacks {
  int? id;
  int? eventId;
  String? description;
  int? userId;
  String? rate;
  String? createdAt;
  String? updatedAt;
  Event? event;

  EventFeedbacks(
      {this.id,
        this.eventId,
        this.description,
        this.userId,
        this.rate,
        this.createdAt,
        this.updatedAt,
        this.event});

  EventFeedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    description = json['description'];
    userId = json['userId'];
    rate = json['rate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventId'] = this.eventId;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['rate'] = this.rate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    return data;
  }
}

class Event {
  String? name;

  Event({this.name});

  Event.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}