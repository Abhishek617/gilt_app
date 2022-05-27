class UpcomingPastEventModal {
  bool? success;
  String? message;
  Events? events;

  UpcomingPastEventModal({this.success, this.message, this.events});

  UpcomingPastEventModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    events =
    json['events'] != null ? new Events.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.events != null) {
      data['events'] = this.events!.toJson();
    }
    return data;
  }
}

class Events {
  int? totalItems;
  List<UpcomingAndPastEventListDetail>? listData;
  int? totalPages;
  int? currentPage;

  Events({this.totalItems, this.listData, this.totalPages, this.currentPage});

  Events.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['listData'] != null) {
      listData = <UpcomingAndPastEventListDetail>[];
      json['listData'].forEach((v) {
        listData!.add(new UpcomingAndPastEventListDetail.fromJson(v));
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

class UpcomingAndPastEventListDetail {
  int? id;
  String? name;
  int? createdBy;
  String? status;
  String? startDate;
  String? endDate;
  String? location;
  List<EventImages>? eventImages;
  int? attendeeCount;

  UpcomingAndPastEventListDetail(
      {this.id,
        this.name,
        this.createdBy,
        this.status,
        this.startDate,
        this.endDate,
        this.location,
        this.eventImages,
        this.attendeeCount});

  UpcomingAndPastEventListDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdBy = json['createdBy'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    location = json['location'];
    if (json['eventImages'] != null) {
      eventImages = <EventImages>[];
      json['eventImages'].forEach((v) {
        eventImages!.add(new EventImages.fromJson(v));
      });
    }
    attendeeCount = json['attendeeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['location'] = this.location;
    if (this.eventImages != null) {
      data['eventImages'] = this.eventImages!.map((v) => v.toJson()).toList();
    }
    data['attendeeCount'] = this.attendeeCount;
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
