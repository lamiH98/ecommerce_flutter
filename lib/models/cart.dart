import 'dart:convert';

// List<Cart> cartFromJson(data) => List<Cart>.from(data.map((value) => Cart.fromJson(value)));
List<Cart> cartFromJson(data) => List<Cart>.from(json.decode(data)["cartItems"].map((value) => Cart.fromJson(value)));

class Cart{

  int? id;
  Map? product;
  Map? size;
  Map? color;
  int? quantity;

  Cart({
    this.id, this.product, this.quantity, this.color, this.size
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    product: json["product"],
    size: json["size"],
    color: json["color"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "color": color,
    "size": size,
    "quantity": quantity,
  };

}

class Total{
  double? total;

  Total({
    this.total
  });

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      total: json['total'].toDouble(),
    );
  }
}