// To parse this JSON data, do
//
//     final moviePreviewModel = moviePreviewModelFromJson(jsonString);

import 'dart:convert';

List<MoviePreviewModel> moviePreviewModelFromJson(String str) => List<MoviePreviewModel>.from(json.decode(str).map((x) => MoviePreviewModel.fromJson(x)));

String moviePreviewModelToJson(List<MoviePreviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviePreviewModel {
  String videoId;
  String title;
  String description;
  String genreName;
  String languageName;
  String bannerLink;
  String bannerType;
  String ratings;

  MoviePreviewModel({
    required this.videoId,
    required this.title,
    required this.description,
    required this.genreName,
    required this.languageName,
    required this.bannerLink,
    required this.bannerType,
    required this.ratings,
  });

  factory MoviePreviewModel.fromJson(Map<String, dynamic> json) => MoviePreviewModel(
    videoId: json["video_id"],
    title: json["title"],
    description: json["description"],
    genreName: json["genre_name"],
    languageName: json["language_name"],
    bannerLink: json["banner_link"],
    bannerType: json["banner_type"],
    ratings: json["ratings"],
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "description": description,
    "genre_name": genreName,
    "language_name": languageName,
    "banner_link": bannerLink,
    "banner_type": bannerType,
    "ratings": ratings,
  };
}
