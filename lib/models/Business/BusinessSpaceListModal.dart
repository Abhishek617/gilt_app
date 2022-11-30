class BusinessSpaceListModal {
  bool? success;
  String? message;
  List<BusinessSpaces>? businessSpaces;

  BusinessSpaceListModal({this.success, this.message, this.businessSpaces});

  BusinessSpaceListModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['businessSpaces'] != null) {
      businessSpaces = <BusinessSpaces>[];
      json['businessSpaces'].forEach((v) {
        businessSpaces!.add(new BusinessSpaces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.businessSpaces != null) {
      data['businessSpaces'] =
          this.businessSpaces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessSpaces {
  int? id;
  String? name;
  Null? slug;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Admin? admin;

  BusinessSpaces(
      {this.id,
        this.name,
        this.slug,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.admin});

  BusinessSpaces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
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
