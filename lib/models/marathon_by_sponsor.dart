class MarathonBySponsor {
  String sponsorId;
  String id;
  String country;
  String title;
  double distance;

  MarathonBySponsor(
      {this.sponsorId, this.id, this.country, this.title, this.distance});

  MarathonBySponsor.fromJson(Map<String, dynamic> json) {
    sponsorId = json['sponsor_id'];
    id = json['id'];
    country = json['country'];
    title = json['title'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sponsor_id'] = this.sponsorId;
    data['id'] = this.id;
    data['country'] = this.country;
    data['title'] = this.title;
    data['distance'] = this.distance;
    return data;
  }
}
