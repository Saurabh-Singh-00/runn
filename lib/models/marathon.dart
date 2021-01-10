class Marathon {
  String country;
  String id;
  String state;
  String city;
  int pincode;
  String dateTime;
  String title;
  String description;
  String organiserEmail;
  List<double> startLocation;
  List<double> endLocation;
  double distance;
  String type;
  List<SponsorType> sponsors;

  Marathon(
      {this.country,
      this.id,
      this.state,
      this.city,
      this.pincode,
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
    id = json['id'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    dateTime = json['date_time'];
    title = json['title'];
    description = json['description'];
    organiserEmail = json['organiser_email'];
    startLocation = json['start_location'].cast<double>();
    endLocation = json['end_location'].cast<double>();
    distance = json['distance'];
    type = json['type'];
    if (json['sponsors'] != null) {
      sponsors = new List<SponsorType>();
      json['sponsors'].forEach((v) {
        sponsors.add(new SponsorType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['id'] = this.id;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['date_time'] = this.dateTime;
    data['title'] = this.title;
    data['description'] = this.description;
    data['organiser_email'] = this.organiserEmail;
    data['start_location'] = this.startLocation;
    data['end_location'] = this.endLocation;
    data['distance'] = this.distance;
    data['type'] = this.type;
    if (this.sponsors != null) {
      data['sponsors'] = this.sponsors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SponsorType {
  String email;
  String name;
  String logo;

  SponsorType({this.email, this.name, this.logo});

  SponsorType.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
