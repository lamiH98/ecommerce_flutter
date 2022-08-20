import 'dart:convert';

List<Size> sizeFromJson(data) => List<Size>.from(json.decode(data)["sizes"].map((value) => Size.fromJson(value)));

String sizeToJson(List<Size> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Size{

  int? id;
  String? size;
  String? sizeAr;

  Size({
    this.id, this.size, this.sizeAr
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    id: json["id"],
    size: json["size"],
    sizeAr: json["size_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size": size,
    "size_ar": sizeAr,
  };

}