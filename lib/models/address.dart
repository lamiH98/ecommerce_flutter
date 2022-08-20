import 'dart:convert';

List<Address> addressFromJson(data) => List<Address>.from(json.decode(data)["userAddress"].map((value) => Address.fromJson(value)));

String addressToJson(List<Address> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));


class Address{

  int? id;
  String? city;
  String? neighourhood;
  String? street;
  bool? check;

  Address({
    this.id, this.city, this.neighourhood, this.street, this.check
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    city: json["city"],
    neighourhood: json["neighourhood"],
    street: json["street"],
    check: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "neighourhood": neighourhood,
    "street": street,
    "default": check,
  };

}