class NotificationListModal {
  NotificationListModal({
    required this.success,
    required this.message,
    required this.notification,
  });
  late final bool success;
  late final String message;
  late final List<dynamic> notification;

  NotificationListModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    notification = List.castFrom<dynamic, dynamic>(json['notification']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['notification'] = notification;
    return _data;
  }
}