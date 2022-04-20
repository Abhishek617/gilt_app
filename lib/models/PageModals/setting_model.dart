class SettingGetModal {
  SettingGetModal({
    required this.success,
    required this.message,
    required this.adminSettings,
  });
  late final bool success;
  late final String message;
  late final AdminSettings adminSettings;

  SettingGetModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    adminSettings = AdminSettings.fromJson(json['admin_settings']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['admin_settings'] = adminSettings.toJson();
    return _data;
  }
}

class AdminSettings {
  AdminSettings({
    required this.userId,
    required this.notification,
  });
  late final int userId;
  late final Notification notification;

  AdminSettings.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    notification = Notification.fromJson(json['notification']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['notification'] = notification.toJson();
    return _data;
  }
}

class Notification {
  Notification({
    required this.isPushNotification,
    required this.isEmailNotification,
    required this.isShowAppIcon,
    required this.isFloatingNotification,
    required this.isLockScreenNotification,
    required this.isAllowSound,
    required this.isAllowVibration,
  });
  late final int isPushNotification;
  late final int isEmailNotification;
  late final int isShowAppIcon;
  late final int isFloatingNotification;
  late final int isLockScreenNotification;
  late final int isAllowSound;
  late final int isAllowVibration;

  Notification.fromJson(Map<String, dynamic> json){
    isPushNotification = json['is_push_notification'];
    isEmailNotification = json['is_email_notification'];
    isShowAppIcon = json['is_show_app_icon'];
    isFloatingNotification = json['is_floating_notification'];
    isLockScreenNotification = json['is_lock_screen_notification'];
    isAllowSound = json['is_allow_sound'];
    isAllowVibration = json['is_allow_vibration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_push_notification'] = isPushNotification;
    _data['is_email_notification'] = isEmailNotification;
    _data['is_show_app_icon'] = isShowAppIcon;
    _data['is_floating_notification'] = isFloatingNotification;
    _data['is_lock_screen_notification'] = isLockScreenNotification;
    _data['is_allow_sound'] = isAllowSound;
    _data['is_allow_vibration'] = isAllowVibration;
    return _data;
  }
}

// class SettingGetModal {
//   bool? success;
//   String? message;
//   AdminSettings? adminSettings;
//
//   SettingGetModal({this.success, this.message, this.adminSettings});
//
//   SettingGetModal.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     adminSettings = json['admin_settings'] != null
//         ? new AdminSettings.fromJson(json['admin_settings'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.adminSettings != null) {
//       data['admin_settings'] = this.adminSettings!.toJson();
//     }
//     return data;
//   }
// }
//
// class AdminSettings {
//   int? userId;
//   Notification? notification;
//
//   AdminSettings({this.userId, this.notification});
//
//   AdminSettings.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     notification = json['notification'] != null
//         ? new Notification.fromJson(json['notification'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     if (this.notification != null) {
//       data['notification'] = this.notification!.toJson();
//     }
//     return data;
//   }
// }
//
// class Notification {
//   int? isPushNotification;
//   int? isEmailNotification;
//   int? isShowAppIcon;
//   int? isFloatingNotification;
//   int? isLockScreenNotification;
//   int? isAllowSound;
//   int? isAllowVibration;
//
//   Notification(
//       {this.isPushNotification,
//         this.isEmailNotification,
//         this.isShowAppIcon,
//         this.isFloatingNotification,
//         this.isLockScreenNotification,
//         this.isAllowSound,
//         this.isAllowVibration});
//
//   Notification.fromJson(Map<String, dynamic> json) {
//     isPushNotification = json['is_push_notification'];
//     isEmailNotification = json['is_email_notification'];
//     isShowAppIcon = json['is_show_app_icon'];
//     isFloatingNotification = json['is_floating_notification'];
//     isLockScreenNotification = json['is_lock_screen_notification'];
//     isAllowSound = json['is_allow_sound'];
//     isAllowVibration = json['is_allow_vibration'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['is_push_notification'] = this.isPushNotification;
//     data['is_email_notification'] = this.isEmailNotification;
//     data['is_show_app_icon'] = this.isShowAppIcon;
//     data['is_floating_notification'] = this.isFloatingNotification;
//     data['is_lock_screen_notification'] = this.isLockScreenNotification;
//     data['is_allow_sound'] = this.isAllowSound;
//     data['is_allow_vibration'] = this.isAllowVibration;
//     return data;
//   }
// }
