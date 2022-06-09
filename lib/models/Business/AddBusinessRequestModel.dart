class AddBusinessRequestModel {
  String? name;
  String? description;
  String? lat;
  String? long;
  String? location;
  String? email;
  String? contact;
  List<dynamic>? files;

  AddBusinessRequestModel(
      {this.name,
        this.description,
        this.lat,
        this.long,
        this.location,
        this.email,
        this.contact,
        this.files});

  AddBusinessRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    lat = json['lat'];
    long = json['long'];
    location = json['location'];
    email = json['email'];
    contact = json['contact'];
    files = json['files'].cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['location'] = this.location;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['files'] = this.files;
    return data;
  }
}
