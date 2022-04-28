class CreateEventRequestModal {
  CreateEventRequestModal({
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
  late final String name;
  late final String category;
  late final String location;
  late final String startDate;
  late final String endDate;
  late final String description;
  late final List<Attendees> attendees;
  late final String expenseDescription;
  late final String lat;
  late final String long;
  late final String totalExpense;

  CreateEventRequestModal.fromJson(Map<String, dynamic> json){
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
  late final String phone;
  late final int expanse;

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