import 'dart:convert';

List<Product> productFromJson(data) => List<Product>.from(json.decode(data)["products"].map((value) => Product.fromJson(value)));
// List<Map<String, dynamic>>.from(json.decode(response.body)['membre'])

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Product{

  int? id;
  String? image;
  String? name;
  String? nameAr;
  String? details;
  String? detailsAr;
  String? price;
  String? priceOffer;
  int? quantity;
  bool? productNew;
  String? createdAt;
  Object? category;
  List? colors;
  List? sizes;
  Object? brand;
  List? images;
  List? reviews;

  Product({
    this.id, this.image, this.name, this.nameAr, this.details, this.detailsAr, this.price, this.priceOffer, this.quantity,
    this.productNew, this.category, this.colors, this.brand, this.sizes, this.images, this.reviews, this.createdAt
  });

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    nameAr: json["name_ar"],
    details: json["details"],
    detailsAr: json["details_ar"],
    price: json["price"],
    priceOffer: json["price_offer"],
    quantity: json["quantity"],
    productNew: json["product_new"],
    category: json["category"],
    colors: json["colors"],
    brand: json["brand"],
    sizes: json["sizes"],
    images: json["images"],
    reviews: json["reviews"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "nameAr": nameAr,
    "details": details,
    "price": price,
    "price_offer": priceOffer,
    "quantity": quantity,
    "productNew": productNew,
    "category": category,
    "colors": colors,
    "brand": brand,
    "sizes": sizes,
    "created_at": createdAt,
  };

}