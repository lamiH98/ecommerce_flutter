import 'dart:convert';

List<OrderProduct> orderProductFromJson(data) => List<OrderProduct>.from(json.decode(data)["orderProducts"].map((value) => OrderProduct.fromJson(value)));

String orderProductToJson(List<OrderProduct> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class OrderProduct{

  int? id;
  int? productId;
  int? orderId;
  int? quantity;
  String? color;
  String? size;
  bool? rating;
  Map? product;

  OrderProduct({
    this.id, this.productId, this.orderId, this.quantity, this.color, this.size, this.rating, this.product
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    id: json["id"],
    productId: json["product_id"],
    orderId: json["order_id"],
    quantity: json["quantity"],
    color: json["color"],
    size: json["size"],
    rating: json["rating"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "orderId": orderId,
    "quantity": quantity,
    "color": color,
    "size": size,
    "product": product,
  };

}