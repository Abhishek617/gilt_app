class RefreshTokenModal {
  bool? success;
  String? accessToken;
  String? message;
  String? refreshToken;

  RefreshTokenModal({this.success, this.message, this.accessToken, this.refreshToken});

  RefreshTokenModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    accessToken = json['accessToken'];
    message = json['message'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['accessToken'] = this.accessToken;
    data['message'] = this.message;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
