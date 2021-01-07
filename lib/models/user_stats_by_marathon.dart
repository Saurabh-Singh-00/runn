class UserStatsByMarathon {
  String marathonId;
  String email;
  String time;
  double lat;
  double long;

  UserStatsByMarathon(
      {this.marathonId, this.email, this.time, this.lat, this.long});

  UserStatsByMarathon.fromJson(Map<String, dynamic> json) {
    marathonId = json['marathon_id'];
    email = json['email'];
    time = json['time'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marathon_id'] = this.marathonId;
    data['email'] = this.email;
    data['time'] = this.time;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}