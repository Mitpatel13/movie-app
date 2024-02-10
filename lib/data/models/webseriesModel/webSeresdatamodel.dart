// To parse this JSON data, do
//
//     final webSeriesDataModel = webSeriesDataModelFromJson(jsonString);

import 'dart:convert';

List<WebSeriesDataModel> webSeriesDataModelFromJson(String str) => List<WebSeriesDataModel>.from(json.decode(str).map((x) => WebSeriesDataModel.fromJson(x)));

String webSeriesDataModelToJson(List<WebSeriesDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WebSeriesDataModel {
  final String? title;
  final String? year;
  final String? categoryName;
  final String? cast;
  final String? description;
  final String? rating;
  final String? banner;
  final String? languageName;
  final List<Season>? seasons;

  WebSeriesDataModel({
    this.title,
    this.year,
    this.categoryName,
    this.cast,
    this.description,
    this.rating,
    this.banner,
    this.languageName,
    this.seasons,
  });

  factory WebSeriesDataModel.fromJson(Map<String, dynamic> json) => WebSeriesDataModel(
    title: json["title"]??'',
    year: json["year"]??'',
    categoryName: json["category_name"]??'',
    cast: json["cast"]??'',
    description: json["description"]??'',
    rating: json["rating"]??'',
    banner: json["banner"]??'',
    languageName: json["language_name"]??'',
    seasons: json["seasons"] == null ? [] : List<Season>.from(json["seasons"]!.map((x) => Season.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "year": year,
    "category_name": categoryName,
    "cast": cast,
    "description": description,
    "rating": rating,
    "banner": banner,
    "language_name": languageName,
    "seasons": seasons == null ? [] : List<dynamic>.from(seasons!.map((x) => x.toJson())),
  };
}

class Season {
  final String? seasonNumber;
  final String? seasonId;

  Season({
    this.seasonNumber,
    this.seasonId,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    seasonNumber: json["season_number"],
    seasonId: json["season_id"],
  );

  Map<String, dynamic> toJson() => {
    "season_number": seasonNumber,
    "season_id": seasonId,
  };
}
