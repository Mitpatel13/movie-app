// To parse this JSON data, do
//
//     final seriesModel = seriesModelFromJson(jsonString);

import 'dart:convert';

List<SeriesModel> seriesModelFromJson(String str) => List<SeriesModel>.from(json.decode(str).map((x) => SeriesModel.fromJson(x)));

String seriesModelToJson(List<SeriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeriesModel {
  final String categoryName;
  final String categoryId;
  final List<Datum> data;

  SeriesModel({
    required this.categoryName,
    required this.categoryId,
    required this.data,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
    categoryName: json["category_name"],
    categoryId: json["category_id"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "category_id": categoryId,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final String webId;
  final String title;
  final String thumbnail;

  Datum({
    required this.webId,
    required this.title,
    required this.thumbnail,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    webId: json["web_id"],
    title: json["title"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "web_id": webId,
    "title": title,
    "thumbnail": thumbnail,
  };
}
