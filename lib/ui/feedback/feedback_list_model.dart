class FeedbackListModel {
  FeedbackListModel({
    required this.success,
    required this.message,
    required this.eventFeedbacks,
  });
  late final bool success;
  late final String message;
  late final List<EventFeedbacks> eventFeedbacks;

  FeedbackListModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    eventFeedbacks = List.from(json['eventFeedbacks']).map((e)=>EventFeedbacks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['eventFeedbacks'] = eventFeedbacks.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class EventFeedbacks {
  EventFeedbacks({
    required this.id,
    required this.eventId,
    required this.description,
    required this.userId,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
    required this.event,
  });
  late final int id;
  late final int eventId;
  late final String description;
  late final int userId;
  late final String rate;
  late final String createdAt;
  late final String updatedAt;
  late final Event event;

  EventFeedbacks.fromJson(Map<String, dynamic> json){
    id = json['id'];
    eventId = json['eventId'];
    description = json['description'];
    userId = json['userId'];
    rate = json['rate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    event = Event.fromJson(json['event']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['eventId'] = eventId;
    _data['description'] = description;
    _data['userId'] = userId;
    _data['rate'] = rate;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['event'] = event.toJson();
    return _data;
  }
}

class Event {
  Event({
    required this.name,
  });
  late final String name;

  Event.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    return _data;
  }
}