// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  Video({
    required this.displayImage,
    required this.link,
    required this.published,
    required this.sourcePage,
    required this.timestamp,
    required this.title,
  });

  final String displayImage;
  final String link;
  final String published;
  final String sourcePage;
  final int timestamp;
  final String title;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    displayImage: json["display_image"],
    link: json["link"],
    published: json["published"],
    sourcePage: json["source_page"],
    timestamp: json["timestamp"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "display_image": displayImage,
    "link": link,
    "published": published,
    "source_page": sourcePage,
    "timestamp": timestamp,
    "title": title,
  };
}
