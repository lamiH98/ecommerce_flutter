import 'dart:convert';

List<Notification> notificationFromJson(data) => List<Notification>.from(json.decode(data)["notifications"].map((value) => Notification.fromJson(value)));

String notificationToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));


class Notification{

  int? id;
  String? title;
  String? body;
  String? titleAr;
  String? bodyAr;
  String? image;
  String? createdAt;

  Notification({
    this.id, this.title, this.body, this.titleAr, this.bodyAr, this.image, this.createdAt
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    titleAr: json["title_ar"],
    bodyAr: json["body_ar"],
    image: json["image"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "title_ar": titleAr,
    "body_ar": bodyAr,
    "image": image,
    "created_at": createdAt,
  };

}