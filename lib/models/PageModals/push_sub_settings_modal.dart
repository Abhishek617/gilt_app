class PushSettingsModal {
  bool? success;
  String? message;
  List<Settings> settings=[];

  PushSettingsModal({this.success, this.message, required this.settings});

  PushSettingsModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['settings'] != null) {
      settings = <Settings>[];
      json['settings'].forEach((v) {
        settings.add(new Settings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.settings != null) {
      data['settings'] = this.settings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  int? id;
  int? notificationTempId;
  bool? isReceive;
  String? label;

  Settings({this.id, this.notificationTempId, this.isReceive, this.label});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationTempId = json['notificationTempId'];
    isReceive = json['isReceive'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notificationTempId'] = this.notificationTempId;
    data['isReceive'] = this.isReceive;
    data['label'] = this.label;
    return data;
  }
  }