class AboutMaster {
  bool? _success;
  String? _message;
  AboutData? _data;

  AboutMaster({bool? success, String? message, AboutData? data}) {
    if (success != null) {
      this._success = success;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;
  AboutData? get data => _data;
  set data(AboutData? data) => _data = data;

  AboutMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? new AboutData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class AboutData {
  String? _title;
  About? _about;

  AboutData({String? title, About? about}) {
    if (title != null) {
      this._title = title;
    }
    if (about != null) {
      this._about = about;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  About? get about => _about;
  set about(About? about) => _about = about;

  AboutData.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _about = json['data'] != null ? new About.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    if (this._about != null) {
      data['about'] = this._about!.toJson();
    }
    return data;
  }
}

class About {
  AppDetails? _ios;
  AppDetails? _android;

  About({AppDetails? ios, AppDetails? android}) {
    if (ios != null) {
      this._ios = ios;
    }
    if (android != null) {
      this._android = android;
    }
  }

  AppDetails? get ios => _ios;
  set ios(AppDetails? ios) => _ios = ios;
  AppDetails? get android => _android;
  set android(AppDetails? android) => _android = android;

  About.fromJson(Map<String, dynamic> json) {
    _ios = json['ios'] != null ? new AppDetails.fromJson(json['ios']) : null;
    _android =
    json['android'] != null ? new AppDetails.fromJson(json['android']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._ios != null) {
      data['ios'] = this._ios!.toJson();
    }
    if (this._android != null) {
      data['android'] = this._android!.toJson();
    }
    return data;
  }
}

class AppDetails {
  String? _version;
  String? _developedBy;
  int? _isForceUpdate;
  String? _msg;
  String? _feature;

  AppDetails(
      {String? version,
        String? developedBy,
        int? isForceUpdate,
        String? msg,
        String? feature}) {
    if (version != null) {
      this._version = version;
    }
    if (developedBy != null) {
      this._developedBy = developedBy;
    }
    if (isForceUpdate != null) {
      this._isForceUpdate = isForceUpdate;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (feature != null) {
      this._feature = feature;
    }
  }

  String? get version => _version;
  set version(String? version) => _version = version;
  String? get developedBy => _developedBy;
  set developedBy(String? developedBy) => _developedBy = developedBy;
  int? get isForceUpdate => _isForceUpdate;
  set isForceUpdate(int? isForceUpdate) => _isForceUpdate = isForceUpdate;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  String? get feature => _feature;
  set feature(String? feature) => _feature = feature;

  AppDetails.fromJson(Map<String, dynamic> json) {
    _version = json['version'];
    _developedBy = json['developed_by'];
    _isForceUpdate = json['is_force_update'];
    _msg = json['msg'];
    _feature = json['feature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this._version;
    data['developed_by'] = this._developedBy;
    data['is_force_update'] = this._isForceUpdate;
    data['msg'] = this._msg;
    data['feature'] = this._feature;
    return data;
  }
}