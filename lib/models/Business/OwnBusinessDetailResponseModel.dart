class OwnBusinessDetailResponseModel {
  bool? success;
  String? message;
  Business? business;

  OwnBusinessDetailResponseModel({this.success, this.message, this.business});

  OwnBusinessDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    return data;
  }
}

class Business {
  int? id;
  String? name;
  String? location;
  LatLong? latLong;
  String? description;
  String? email;
  String? contact;
  int? createdBy;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  Admin? admin;
  List<BusinessPhotos>? businessPhotos;

  Business(
      {this.id,
        this.name,
        this.location,
        this.latLong,
        this.description,
        this.email,
        this.contact,
        this.createdBy,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.admin,
        this.businessPhotos});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    latLong =
    json['latLong'] != null ? new LatLong.fromJson(json['latLong']) : null;
    description = json['description'];
    email = json['email'];
    contact = json['contact'];
    createdBy = json['createdBy'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
    if (json['BusinessPhotos'] != null) {
      businessPhotos = <BusinessPhotos>[];
      json['BusinessPhotos'].forEach((v) {
        businessPhotos!.add(new BusinessPhotos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    if (this.latLong != null) {
      data['latLong'] = this.latLong!.toJson();
    }
    data['description'] = this.description;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['createdBy'] = this.createdBy;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
    if (this.businessPhotos != null) {
      data['BusinessPhotos'] =
          this.businessPhotos!.map((v) => v.toJson()).toList();
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

class Admin {
  String? firstname;
  String? lastname;

  Admin({this.firstname, this.lastname});

  Admin.fromJson(Map<String, dynamic> json) {
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

class BusinessPhotos {
  String? name;

  BusinessPhotos({this.name});

  BusinessPhotos.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
