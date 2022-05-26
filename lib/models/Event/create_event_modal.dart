class CreateEventRequestModal {
  CreateEventRequestModal({
    required this.files,
    required this.name,
    required this.category,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.attendees,
    required this.expenseDescription,
    required this.lat,
    required this.long,
    required this.totalExpense,
  });
  late dynamic files;
  late String name;
  late String category;
  late String location;
  late String startDate;
  late String endDate;
  late String description;
  late List<Attendees> attendees;
  late String expenseDescription;
  late String lat;
  late String long;
  late String totalExpense;

  CreateEventRequestModal.fromJson(Map<String, dynamic> json){
    files = json['files'];
    name = json['name'];
    category = json['category'];
    location = json['location'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    attendees = List.from(json['attendees']).map((e)=>Attendees.fromJson(e)).toList();
    expenseDescription = json['expenseDescription'];
    lat = json['lat'];
    long = json['long'];
    totalExpense = json['totalExpense'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['files'] = files;
    _data['name'] = name;
    _data['category'] = category;
    _data['location'] = location;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['description'] = description;
    _data['attendees'] = attendees.map((e)=>e.toJson()).toList();
    _data['expenseDescription'] = expenseDescription;
    _data['lat'] = lat;
    _data['long'] = long;
    _data['totalExpense'] = totalExpense;
    return _data;
  }
}

class Attendees {
  Attendees({
    required this.phone,
    required this.expanse,
  });
  late String phone;
  late double expanse;

  Attendees.fromJson(Map<String, dynamic> json){
    phone = json['phone'];
    expanse = json['expanse'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    _data['expanse'] = expanse;
    return _data;
  }
}