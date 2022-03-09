class SuccessErrorValidationPageArgs {
  bool isSuccess = true;
  String title = '';
  String description = '';
  bool isPreviousLogin = true;

  SuccessErrorValidationPageArgs(
      {required this.isSuccess,
      required this.title,
      required this.description,
      required this.isPreviousLogin});

  SuccessErrorValidationPageArgs.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    title = json['title'];
    description = json['description'];
    isPreviousLogin = json['isPreviousLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isPreviousLogin'] = this.isPreviousLogin;
    return data;
  }
}
