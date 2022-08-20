import 'dart:convert';

List<Review> reviewFromJson(data) => List<Review>.from(json.decode(data)["reviews"].map((value) => Review.fromJson(value)));

class Review{

  int? productId;
  int? userId;
  double? review;
  String? comment;

  Review({
    this.productId, this.userId, this.review, this.comment
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    productId: json["product_id"],
    userId: json["user_id"],
    review: json["review"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "user_id": userId,
    "review": review,
    "comment": comment,
  };

}