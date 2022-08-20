import 'dart:convert';

List<Category> categoryFromJson(data) => List<Category>.from(json.decode(data)["categories"].map((value) => Category.fromJson(value)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Category{

  int? id;
  String? image;
  String? name;
  String? nameAr;
  int? parentId;
  List? subcategory;

  Category({
    this.id, this.image, this.name, this.nameAr, this.parentId, this.subcategory
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    nameAr: json["name_ar"],
    parentId: json["parent_id"],
    subcategory: json["subcategory"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "name_ar": nameAr,
    "parentId": parentId,
    "subcategory": subcategory,
  };

}