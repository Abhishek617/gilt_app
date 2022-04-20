class NotificationListModal {
  NotificationListModal({
    required this.success,
    required this.message,
    required this.notification,
  });
  late final bool success;
  late final String message;
  late final List<Notification> notification;

  NotificationListModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    notification = List.from(json['notification']).map((e)=>Notification.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['notification'] = notification.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Notification {
  Notification({
    required this.id,
    required this.userId,
    required this.message,
    required this.isButton,
    required this.username,
    required this.createdAt,
  });
  late final int id;
  late final int userId;
  late final String message;
  late final String isButton;
  late final String username;
  late final String createdAt;

  Notification.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    message = json['message'];
    isButton = json['is_button'];
    username = json['username'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['message'] = message;
    _data['is_button'] = isButton;
    _data['username'] = username;
    _data['createdAt'] = createdAt;
    return _data;
  }
}