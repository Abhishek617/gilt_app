class ExpenseModal {
  ExpenseModal({
    required this.name,
    required this.category,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.contact,
    required this.expenseDescription,
    required this.lat,
    required this.long,
    required this.totalExpense,
  });

  late final String name;
  late final String category;
  late final String location;
  late final String startDate;
  late final String endDate;
  late final String description;
  List<Scontact>? contact;
  late final String expenseDescription;
  late final String lat;
  late final String long;
  late final String totalExpense;

  ExpenseModal.fromJson(Map<String, dynamic> json){
    name = json['name'];
    category = json['category'];
    location = json['location'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    if (json['contact'] != null) {
      contact = <Scontact>[];
      json['contact'].forEach((v) {
        contact!.add(new Scontact.fromJson(v));
      });
    }
    expenseDescription = json['expenseDescription'];
    lat = json['lat'];
    long = json['long'];
    totalExpense = json['totalExpense'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['category'] = category;
    _data['location'] = location;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['description'] = description;
    if (this.contact != null) {
      _data['contact'] = this.contact!.map((v) => v.toJson()).toList();
    }
    _data['expenseDescription'] = expenseDescription;
    _data['lat'] = lat;
    _data['long'] = long;
    _data['totalExpense'] = totalExpense;
    return _data;
  }
}

  class Scontact {
  String? phone;
  int? isExist;
  int? userId;
  String? profile;
  bool? visible = false;

  Scontact({this.phone, this.isExist, this.userId, this.profile, this.visible});

  Scontact.fromJson(Map<String, dynamic> json) {
  phone = json['phone'];
  isExist = json['is_exist'];
  userId = json['user_id'];
  profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['phone'] = this.phone;
  data['is_exist'] = this.isExist;
  data['user_id'] = this.userId;
  data['profile'] = this.profile;
  return data;
  }
  }
