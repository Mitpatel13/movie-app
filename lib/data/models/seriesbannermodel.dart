// To parse this JSON data, do
//
//     final seriesBannerModel = seriesBannerModelFromJson(jsonString);

import 'dart:convert';

List<SeriesBannerModel> seriesBannerModelFromJson(String str) => List<SeriesBannerModel>.from(json.decode(str).map((x) => SeriesBannerModel.fromJson(x)));

String seriesBannerModelToJson(List<SeriesBannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeriesBannerModel {
  String videoId;
  String title;
  String thumbnail;

  SeriesBannerModel({
    required this.videoId,
    required this.title,
    required this.thumbnail,
  });

  factory SeriesBannerModel.fromJson(Map<String, dynamic> json) => SeriesBannerModel(
    videoId: json["video_id"],
    title: json["title"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "thumbnail": thumbnail,
  };
}
