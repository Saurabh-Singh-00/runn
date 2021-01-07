class User {
  String email;
  String name;
  String pic;
  String dob;

  User({this.email, this.name, this.pic, this.dob});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    pic = json['pic'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['dob'] = this.dob;
    return data;
  }
}