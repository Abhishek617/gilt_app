class EventDetailsResponseModel {
  bool? success;
  String? message;
  Event? event;

  EventDetailsResponseModel({this.success, this.message, this.event});

  EventDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    return data;
  }
}

class Event {
  int? id;
  String? name;
  String? category;
  String? location;
  LatLong? latLong;
  String? startDate;
  String? endDate;
  String? description;
  String? expenseDescription;
  int? totalExpense;
  int? createdBy;
  String? status;
  String? createdAt;
  String? updatedAt;
  Organizer? organizer;
  List<EventImages>? eventImages;
  List<EventAttendees1>? eventAttendees;
  bool? isUserAtendee;

  Event(
      {this.id,
        this.name,
        this.category,
        this.location,
        this.latLong,
        this.startDate,
        this.endDate,
        this.description,
        this.expenseDescription,
        this.totalExpense,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.organizer,
        this.eventImages,
        this.eventAttendees,
        this.isUserAtendee});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    location = json['location'];
    latLong =
    json['latLong'] != null ? new LatLong.fromJson(json['latLong']) : null;
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    expenseDescription = json['expenseDescription'];
    totalExpense = json['totalExpense'];
    createdBy = json['createdBy'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    organizer = json['organizer'] != null
        ? new Organizer.fromJson(json['organizer'])
        : null;
    if (json['eventImages'] != null) {
      eventImages = <EventImages>[];
      json['eventImages'].forEach((v) {
        eventImages!.add(new EventImages.fromJson(v));
      });
    }
    if (json['eventAttendees'] != null) {
      eventAttendees = <EventAttendees1>[];
      json['eventAttendees'].forEach((v) {
        eventAttendees!.add(new EventAttendees1.fromJson(v));
      });
    }
    isUserAtendee = json['isUserAtendee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['location'] = this.location;
    if (this.latLong != null) {
      data['latLong'] = this.latLong!.toJson();
    }
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['expenseDescription'] = this.expenseDescription;
    data['totalExpense'] = this.totalExpense;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.organizer != null) {
      data['organizer'] = this.organizer!.toJson();
    }
    if (this.eventImages != null) {
      data['eventImages'] = this.eventImages!.map((v) => v.toJson()).toList();
    }
    if (this.eventAttendees != null) {
      data['eventAttendees'] =
          this.eventAttendees!.map((v) => v.toJson()).toList();
    }
    data['isUserAtendee'] = this.isUserAtendee;
    return data;
  }
}

class LatLong {
  String? type;
  List<double>? coordinates;

  LatLong({this.type, this.coordinates});

  LatLong.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Organizer {
  String? firstname;
  String? lastname;
  int? id;

  Organizer({this.firstname, this.lastname, this.id});

  Organizer.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['id'] = this.id;
    return data;
  }
}

class EventImages {
  String? file;

  EventImages({this.file});

  EventImages.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    return data;
  }
}

class EventAttendees1 {
  int? userId;
  double? expense;
  Admin? admin;

  EventAttendees1({this.userId, this.expense, this.admin});

  EventAttendees1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    expense = json['expense'] != null ? json['expense'].toDouble() : 0;
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expense'] = this.expense;
    data['userId'] = this.userId;
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
    return data;
  }
}

class Admin {
  String? firstname;
  String? lastname;
  String? phone;

  Admin({this.firstname, this.lastname, this.phone});

  Admin.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    return data;
  }
}
