class Sponsor {
  String email;
  String name;
  String logo;
  String website;
  String description;

  Sponsor({this.email, this.name, this.logo, this.website, this.description});

  Sponsor.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    logo = json['logo'];
    website = json['website'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['website'] = this.website;
    data['description'] = this.description;
    return data;
  }
}