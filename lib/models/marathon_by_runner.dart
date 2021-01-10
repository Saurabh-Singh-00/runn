class MarathonByRunner {
  String userEmail;
  String country;
  String id;
  String title;
  double distance;

  MarathonByRunner(
      {this.userEmail, this.country, this.id, this.title, this.distance});

  MarathonByRunner.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    country = json['country'];
    id = json['id'];
    title = json['title'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['country'] = this.country;
    data['id'] = this.id;
    data['title'] = this.title;
    data['distance'] = this.distance;
    return data;
  }
}
