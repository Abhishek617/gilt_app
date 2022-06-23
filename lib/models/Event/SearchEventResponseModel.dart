class SearchEventResponseModal {
  bool? success;
  String? message;
  EventsList? eventsList;

  SearchEventResponseModal({this.success, this.message, this.eventsList});

  SearchEventResponseModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    eventsList = json['eventsList'] != null
        ? new EventsList.fromJson(json['eventsList'])
        : json['events'] != null
        ? new EventsList.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.eventsList != null) {
      data['eventsList'] = this.eventsList!.toJson();
    }
    return data;
  }
}

class EventsList {
  int? totalItems;
  List<EventItem>? listData;
  int? totalPages;
  int? currentPage;

  EventsList(
      {this.totalItems, this.listData, this.totalPages, this.currentPage});

  EventsList.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['listData'] != null) {
      listData = <EventItem>[];
      json['listData'].forEach((v) {
        listData!.add(new EventItem.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.listData != null) {
      data['listData'] = this.listData!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class EventItem {
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
  List<EventImages1>? eventImages;
  List<EventAttendees>? eventAttendees;

  EventItem(
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
        this.eventAttendees});

  EventItem.fromJson(Map<String, dynamic> json) {
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
      eventImages = <EventImages1>[];
      json['eventImages'].forEach((v) {
        eventImages!.add(new EventImages1.fromJson(v));
      });
    }
    if (json['eventAttendees'] != null) {
      eventAttendees = <EventAttendees>[];
      json['eventAttendees'].forEach((v) {
        eventAttendees!.add(new EventAttendees.fromJson(v));
      });
    }
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

  Organizer({this.firstname, this.lastname});

  Organizer.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}

class EventImages1 {
  String? file;

  EventImages1({this.file});

  EventImages1.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    return data;
  }
}

class EventAttendees {
  int? userId;
  Admin? admin;

  EventAttendees({this.userId, this.admin});

  EventAttendees.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
