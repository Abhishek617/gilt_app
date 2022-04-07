class UpcomingPastEventModal {
  UpcomingPastEventModal( {
    required this.success,
    required this.message,
    required this.events,
  });
  late final bool success;
  late final String message;
  late final Events events;

  UpcomingPastEventModal.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    events = Events.fromJson(json['events']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['events'] = events.toJson();
    return _data;
  }
}

class Events {
  Events({
    required this.totalItems,
    required this.listData,
    required this.totalPages,
    required this.currentPage,
  });
  late final int totalItems;
  late final List<ListData> listData;
  late final int totalPages;
  late final int currentPage;

  Events.fromJson(Map<String, dynamic> json){
    totalItems = json['totalItems'];
    listData = List.from(json['listData']).map((e)=>ListData.fromJson(e)).toList();
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalItems'] = totalItems;
    _data['listData'] = listData.map((e)=>e.toJson()).toList();
    _data['totalPages'] = totalPages;
    _data['currentPage'] = currentPage;
    return _data;
  }
}

class ListData {
  ListData({
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

  ListData.fromJson(Map<String, dynamic> json){
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