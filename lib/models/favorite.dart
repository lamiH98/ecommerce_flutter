import 'dart:convert';

List<Favorite> favoriteFromJson(data) => List<Favorite>.from(json.decode(data)["userFavorite"].map((value) => Favorite.fromJson(value)));

class Favorite{

  int? id;
  int? userId;
  int? productId;
  Object? products;

  Favorite({
    this.id, this.products, this.productId, this.userId
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    products: json["product"],
    productId: json["product_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": products,
    "product_id": productId,
    "user_id": userId,
  };

}