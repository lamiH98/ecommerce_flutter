import 'dart:convert';

List<Coupon> couponFromJson(data) => List<Coupon>.from(json.decode(data)["coupons"].map((value) => Coupon.fromJson(value)));

String couponToJson(List<Coupon> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Coupon{

  int? id;
  String? code;
  String? type;
  String? value;
  String? percentOff;
  int? newTotal;
  int? discount;

  Coupon({
    this.id, this.code, this.type, this.value, this.percentOff, this.newTotal, this.discount
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    code: json["code"],
    type: json["type"],
    value: json["value"],
    percentOff: json["percent_off"],
    newTotal: json["newTotal"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "type": type,
    "value": value,
    "percent_off": percentOff,
  };

}