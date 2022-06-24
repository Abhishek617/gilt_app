class EmailSettingsModal {
  bool? success;
  String? message;
  List<Settings> settings=[];

  EmailSettingsModal({this.success, this.message, required this.settings});

  EmailSettingsModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['settings'] != null) {
      settings = <Settings>[];
      json['settings'].forEach((v) {
        settings!.add(new Settings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.settings != null) {
      data['settings'] = this.settings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  int? id;
  bool? isReceive;
  int? mailTemplateId;
  Null? label;

  Settings({this.id, this.isReceive, this.mailTemplateId, this.label});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isReceive = json['isReceive'];
    mailTemplateId = json['mailTemplateId'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isReceive'] = this.isReceive;
    data['mailTemplateId'] = this.mailTemplateId;
    data['label'] = this.label;
    return data;
  }
}