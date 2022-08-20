import 'dart:convert';

List<Brand> brandFromJson(data) => List<Brand>.from(json.decode(data)["brands"].map((value) => Brand.fromJson(value)));

String brandToJson(List<Brand> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Brand{

  int? id;
  String? image;
  String? brand;
  String? brandAr;

  Brand({
    this.id, this.image, this.brand, this.brandAr
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    image: json["image"],
    brand: json["brand"],
    brandAr: json["brand_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "brand": brand,
    "brand_ar": brandAr,
  };

}