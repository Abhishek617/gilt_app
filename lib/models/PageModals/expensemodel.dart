class ExpenseModal {
  ExpenseModal({
    required this.name,
    required this.category,
    required this.location,
    required this.startDate,
    required this.description,
    this.selectedcontactexpenselist,
  });

  late final String name;
  late final String category;
  late final String location;
  late final String startDate;
  late final String description;
  List<Scontact>? selectedcontactexpenselist;


  ExpenseModal.fromJson(Map<String, dynamic> json){
    name = json['name'];
    category = json['category'];
    location = json['location'];
    startDate = json['startDate'];
    description = json['description'];
    if (json['selectedcontactexpenselist'] != null) {
      selectedcontactexpenselist = <Scontact>[];
      json['selectedcontactexpenselist'].forEach((v) {
        selectedcontactexpenselist!.add(new Scontact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['category'] = category;
    _data['location'] = location;
    _data['startDate'] = startDate;
    _data['description'] = description;
    if (this.selectedcontactexpenselist != null) {
      _data['selectedcontactexpenselist'] = this.selectedcontactexpenselist!.map((v) => v.toJson()).toList();
    }
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
