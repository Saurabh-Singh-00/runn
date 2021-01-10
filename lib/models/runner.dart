class Runner {
  String marathonId;
  String marathonCountry;
  String email;
  String name;
  String pic;
  String participationType;
  String joinedAt;

  Runner(
      {this.marathonId,
      this.marathonCountry,
      this.email,
      this.name,
      this.pic,
      this.participationType,
      this.joinedAt});

  Runner.fromJson(Map<String, dynamic> json) {
    marathonId = json['marathon_id'];
    marathonCountry = json['marathon_country'];
    email = json['email'];
    name = json['name'];
    pic = json['pic'];
    participationType = json['participation_type'];
    joinedAt = json['joined_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marathon_id'] = this.marathonId;
    data['marathon_country'] = this.marathonCountry;
    data['email'] = this.email;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['participation_type'] = this.participationType;
    data['joined_at'] = this.joinedAt;
    return data;
  }
}
