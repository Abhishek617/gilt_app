class PaymentMethod {
  String? _methodName;
  String? _method;
  bool? _isSelected;

  PaymentMethod({String? methodName, String? method, bool? isSelected}) {
    this._methodName = methodName;
    this._method = method;
    this._isSelected = isSelected;
  }

  String get methodName => _methodName!;
  set methodName(String methodName) => _methodName = methodName;
  String get method => _method!;
  set method(String method) => _method = method;
  bool get isSelected => _isSelected?? false;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    _methodName = json['methodName'];
    _method = json['method'];
    _isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['methodName'] = this._methodName;
    data['method'] = this._method;
    data['isSelected'] = this._isSelected;
    return data;
  }
}