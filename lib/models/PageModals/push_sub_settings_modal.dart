class PushSettingsModal {
  PushSettingsModal({
    required this.success,
    required this.message,
    required this.settings,
  });
  late final bool success;
  late final String message;
  late final List<Settings> settings;

  PushSettingsModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    settings = List.from(json['settings']).map((e)=>Settings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['settings'] = settings.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Settings {
  Settings({
    required this.id,
    required this.notificationTempId,
    required this.isReceive,
    required this.label,
  });
  late final int id;
  late final int notificationTempId;
  late final bool isReceive;
  late final String label;

  Settings.fromJson(Map<String, dynamic> json){
    id = json['id'];
    notificationTempId = json['notificationTempId'];
    isReceive = json['isReceive'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['notificationTempId'] = notificationTempId;
    _data['isReceive'] = isReceive;
    _data['label'] = label;
    return _data;
  }
}