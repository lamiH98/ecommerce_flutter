import 'dart:convert';

List<User> userFromJson(data) => List<User>.from(json.decode(data)["users"].map((value) => User.fromJson(value)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class User{

  int? id;
  String? name;
  String? image;
  String? email;
  String? password;

  User({
    this.id, this.name, this.email, this.password, this.image
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "image": image,
  };

}
