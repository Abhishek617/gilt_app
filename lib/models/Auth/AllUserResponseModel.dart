class AllUserResponseModel {
  bool? success;
  String? message;
  List<SearchUserData>? data;

  AllUserResponseModel({this.success, this.message, this.data});

  AllUserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchUserData>[];
      json['data'].forEach((v) {
        data!.add(new SearchUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchUserData {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;

  SearchUserData({this.id, this.firstname, this.lastname, this.email, this.phone});

  SearchUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
