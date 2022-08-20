import 'dart:convert';

List<Slider> sliderFromJson(data) => List<Slider>.from(json.decode(data)["sliders"].map((value) => Slider.fromJson(value)));

String sliderToJson(List<Slider> data) => json.encode(List<dynamic>.from(data.map((value) => value.toJson())));

class Slider{

  int? id;
  String? image;
  String? title;
  String? titleAr;
  String? subtitle;
  String? subtitleAr;

  Slider({
    this.id, this.image, this.title, this.titleAr, this.subtitle, this.subtitleAr
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    titleAr: json["title_ar"],
    subtitle: json["subtitle"],
    subtitleAr: json["subtitle_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "title_ar": titleAr,
    "subtitle": subtitle,
    "subtitle_ar": subtitleAr
  };

}
