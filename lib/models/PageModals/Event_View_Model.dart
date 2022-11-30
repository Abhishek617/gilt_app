class EventViewModal {
  EventViewModal({
    required this.success,
    required this.message,
    required this.event,
  });
  late final bool success;
  late final String message;
  late final Event event;

  EventViewModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    event = Event.fromJson(json['event']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['event'] = event.toJson();
    return _data;
  }
}

class Event {
  Event({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.latLong,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.expenseDescription,
    required this.totalExpense,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.organizer,
    required this.eventImages,
    required this.eventAttendees,
  });
  late final int id;
  late final String name;
  late final String category;
  late final String location;
  late final LatLong latLong;
  late final String startDate;
  late final String endDate;
  late final String description;
  late final String expenseDescription;
  late final int totalExpense;
  late final int createdBy;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final Organizer organizer;
  late final List<dynamic> eventImages;
  late final List<EventAttendees> eventAttendees;

  Event.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    category = json['category'];
    location = json['location'];
    latLong = LatLong.fromJson(json['latLong']);
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    expenseDescription = json['expenseDescription'];
    totalExpense = json['totalExpense'];
    createdBy = json['createdBy'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    organizer = Organizer.fromJson(json['organizer']);
    eventImages = List.castFrom<dynamic, dynamic>(json['eventImages']);
    eventAttendees = List.from(json['eventAttendees']).map((e)=>EventAttendees.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['category'] = category;
    _data['location'] = location;
    _data['latLong'] = latLong.toJson();
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['description'] = description;
    _data['expenseDescription'] = expenseDescription;
    _data['totalExpense'] = totalExpense;
    _data['createdBy'] = createdBy;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['organizer'] = organizer.toJson();
    _data['eventImages'] = eventImages;
    _data['eventAttendees'] = eventAttendees.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class LatLong {
  LatLong({
    required this.type,
    required this.coordinates,
  });
  late final String type;
  late final List<double> coordinates;

  LatLong.fromJson(Map<String, dynamic> json){
    type = json['type'];
    coordinates = List.castFrom<dynamic, double>(json['coordinates']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['coordinates'] = coordinates;
    return _data;
  }
}

class Organizer {
  Organizer({
    required this.firstname,
    required this.lastname,
  });
  late final String firstname;
  late final String lastname;

  Organizer.fromJson(Map<String, dynamic> json){
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    return _data;
  }
}

class EventAttendees {
  EventAttendees({
    required this.userId,
    required this.admin,
  });
  late final int userId;
  late final Admin admin;

  EventAttendees.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    admin = Admin.fromJson(json['admin']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['admin'] = admin.toJson();
    return _data;
  }
}

class Admin {
  Admin({
    required this.firstname,
    required this.lastname,
    required this.phone,
  });
  late final String firstname;
  late final String lastname;
  late final String phone;

  Admin.fromJson(Map<String, dynamic> json){
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['phone'] = phone;
    return _data;
  }
}