import 'dart:convert';

List<Order> orderFromJson(data) => List<Order>.from(json.decode(data)["orders"].map((value) => Order.fromJson(value)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Order{

  int? id;
  int? userId;
  String? name;
  String? email;
  String? city;
  String? neighourhood;
  String? street;
  String? phone;
  String? discount;
  String? discountCode;
  String? total;
  String? newTotal;
  String? error;
  String? status;
  String? deliveryStatus;
  String? createdAt;
  List? products;

  Order({
    this.id, this.userId, this.name, this.email, this.city, this.neighourhood, this.street, this.phone, this.discount,
    this.discountCode, this.newTotal, this.total, this.error, this.products, this.status ,this.deliveryStatus, this.createdAt
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    city: json["city"],
    neighourhood: json["neighourhood"],
    street: json["street"],
    phone: json["phone"],
    discount: json["discount"],
    discountCode: json["discount_code"],
    newTotal: json["newTotal"],
    total: json["total"],
    error: json["error"],
    status: json["status"],
    products: json["products"],
    createdAt: json["created_at"],
    deliveryStatus: json["delivery_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "email": email,
    "city": city,
    "neighourhood": neighourhood,
    "street": street,
    "phone": phone,
    "discount": discount,
    "discount_code": discountCode,
    "newTotal": newTotal,
    "total": total,
    "status": status,
    "delivery_status": deliveryStatus,
    "cart": [],
  };

}