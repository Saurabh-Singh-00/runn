class MarathonsByRunner {
  String userEmail;
  String id;
  String dateTime;
  String title;
  int distance;
  String country;
  String city;
  String state;
  int pincode;

  MarathonsByRunner(
      {this.userEmail,
        this.id,
        this.dateTime,
        this.title,
        this.distance,
        this.country,
        this.city,
        this.state,
        this.pincode});

  MarathonsByRunner.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    id = json['id'];
    dateTime = json['date_time'];
    title = json['title'];
    distance = json['distance'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['id'] = this.id;
    data['date_time'] = this.dateTime;
    data['title'] = this.title;
    data['distance'] = this.distance;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}
