class BaseResponseModel {
  dynamic results;

  BaseResponseModel({
   this.results,
  });

  factory BaseResponseModel.fromJson(Map<dynamic, dynamic> json) => BaseResponseModel(
    results: json["results"],
  );
}


class Results {
  User user;
  String seed;
  String version;

  Results({
    required this.user,
    required this.seed,
    required this.version,
  });

  factory Results.fromMap(Map<String, dynamic> json) => Results(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    seed: json["seed"] == null ? null : json["seed"],
    version: json["version"] == null ? null : json["version"],
  );
}

class User {
  String gender;
  Name name;
  Location location;
  String email;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String phone;
  String cell;
  String ssl;
  String picture;

  User({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
    required this.registered,
    required this.dob,
    required this.phone,
    required this.cell,
    required this.ssl,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        gender: json['gender'] as String,
        name: Name.fromMap(json['name'] as Map<String, dynamic>),
        location: Location.fromMap(json['location'] as Map<String, dynamic>),
        email: json['email'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        salt: json['salt'] as String,
        md5: json['md5'] as String,
        sha1: json['sha1'] as String,
        sha256: json['sha256'] as String,
        registered: json['registered'] as String,
        dob: json['dob'] as String,
        phone: json['phone'] as String,
        cell: json['cell'] as String,
        ssl: json['SSN'] as String,
        picture: json['picture'] as String,
      );

  Map<String, dynamic> toMap() => {
    "gender": gender == null ? null : gender,
    "first": name == null ? null : name.toMap(),
    "last": location == null ? null : location.toMap(),
    "email": email == null ? null : email,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "salt": salt == null ? null : salt,
    "md5": md5 == null ? null : md5,
    "sha1": sha1 == null ? null : sha1,
    "sha256": sha256 == null ? null : sha256,
    "registered": registered == null ? null : registered,
    "dob": dob == null ? null : dob,
    "phone": phone == null ? null : phone,
    "cell": cell == null ? null : cell,
    "ssl": ssl == null ? null : ssl,
    "picture": picture == null ? null : picture,
  };
}

class Name {
  String title;
  String first;
  String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromMap(Map<String, dynamic> json) => Name(
        title: json["title"] == null ? null : json["title"],
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
      );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
    "first": first == null ? null : first,
    "last": last == null ? null : last,
  };

}

class Location {
  String street;
  String city;
  String state;
  String zip;

  Location({
    required this.street,
    required this.state,
    required this.city,
    required this.zip,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        street: json["street"] == null ? null : json["street"],
        state: json["city"] == null ? null : json["city"],
        city: json["state"] == null ? null : json["state"],
        zip: json["zip"] == null ? null : json["zip"],
      );

  Map<String, dynamic> toMap() => {
    "street": street == null ? null : street,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "zip": zip == null ? null : zip,
  };
}
