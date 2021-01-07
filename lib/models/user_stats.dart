class UserStats {
  String email;
  int steps;
  int distance;

  UserStats({this.email, this.steps, this.distance});

  UserStats.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    steps = json['steps'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['steps'] = this.steps;
    data['distance'] = this.distance;
    return data;
  }
}