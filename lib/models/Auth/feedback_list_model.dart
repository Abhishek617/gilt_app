class Feedback_list_Model {
  String? description;
  int? eventId;
  String? rate;

  Feedback_list_Model({this.description, this.eventId, this.rate});

  Feedback_list_Model.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    eventId = json['eventId'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['eventId'] = this.eventId;
    data['rate'] = this.rate;
    return data;
  }
}