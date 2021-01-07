class Marathon {
  String country;
  String state;
  String city;
  int pincode;
  String id;
  String dateTime;
  String title;
  String description;
  String organiserEmail;
  List<int> startLocation;
  List<int> endLocation;
  int distance;
  String type;
  List<SponsorType> sponsors;

  Marathon(
      {this.country,
        this.state,
        this.city,
        this.pincode,
        this.id,
        this.dateTime,
        this.title,
        this.description,
        this.organiserEmail,
        this.startLocation,
        this.endLocation,
        this.distance,
        this.type,
        this.sponsors});

  Marathon.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    id = json['id'];
    dateTime = json['date_time'];
    title = json['title'];
    description = json['description'];
    organiserEmail = json['organiser_email'];
    startLocation = json['start_location'].cast<int>();
    endLocation = json['end_location'].cast<int>();
    distance = json['distance'];
    type = json['type'];
    if (json['sponsors'] != null) {
      sponsors = new List<SponsorType>();
      json['sponsor_type'].forEach((v) {
        sponsors.add(new SponsorType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['id'] = this.id;
    data['date_time'] = this.dateTime;
    data['title'] = this.title;
    data['description'] = this.description;
    data['organiser_email'] = this.organiserEmail;
    data['start_location'] = this.startLocation;
    data['end_location'] = this.endLocation;
    data['distance'] = this.distance;
    data['type'] = this.type;
    if (this.sponsors != null) {
      data['sponsor_type'] = this.sponsors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SponsorType {
  String id;
  String name;
  String logo;

  SponsorType({this.id, this.name, this.logo});

  SponsorType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
