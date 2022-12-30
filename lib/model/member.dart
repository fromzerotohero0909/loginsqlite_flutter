class Member {
  int? id;
  String? name;
  String? address;
  String? date;
  String? username;
  String? password;
  String? gender;

  Member(
      {this.id,
      this.name,
      this.address,
        this.gender,
      this.date,
      this.username,
      this.password});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['address'] = address;
    map['date'] = date;
      map['gender'] = gender;
    map['username'] = username;
    map['password'] = password;

    return map;
  }

  Member.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.address = map['address'];
    this.date = map['date'];
    this.gender = map['gender'];
    this.username = map['username'];
    this.password = map['password'];
  }
}
