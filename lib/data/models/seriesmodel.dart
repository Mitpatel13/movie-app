// To parse this JSON data, do
//
//     final seriesModel = seriesModelFromJson(jsonString);

import 'dart:convert';

List<SeriesModel> seriesModelFromJson(String str) => List<SeriesModel>.from(json.decode(str).map((x) => SeriesModel.fromJson(x)));

String seriesModelToJson(List<SeriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeriesModel {
  String? videoId;
  String? title;
  String? thumbnail;
  String? ratings;
  String? payPerView;
  String? videoPrice;

  SeriesModel({
     this.videoId,
     this.title,
     this.thumbnail,
     this.ratings,
     this.payPerView,
     this.videoPrice,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
    videoId: json["video_id"]??"",
    title: json["title"]??"",
    thumbnail: json["thumbnail"]??"",
    ratings: json["ratings"]??"",
    payPerView: json["pay_per_view"]??"",
    videoPrice: json["video_price"]??"",
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "thumbnail": thumbnail,
    "ratings": ratings,
    "pay_per_view": payPerView,
    "video_price": videoPrice,
  };
}
