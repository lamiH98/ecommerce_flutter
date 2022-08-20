import 'dart:convert';

List<Color> colorFromJson(data) => List<Color>.from(json.decode(data)["colors"].map((value) => Color.fromJson(value)));

String colorToJson(List<Color> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Color{

  int? id;
  String? colorName;
  String? colorNameAr;
  String? color;

  Color({
    this.id, this.colorName, this.colorNameAr, this.color
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
    id: json["id"],
    colorName: json["color_name"],
    colorNameAr: json["color_name_ar"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color_name": colorName,
    "color_name_ar": colorNameAr,
    "color": color,
  };

}