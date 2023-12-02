// To parse this JSON data, do
//
//     final DownloadMovieModel = DownloadMovieModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_downloader/flutter_downloader.dart';

List<DownloadMovieModel> DownloadMovieModelFromJson(String str) => List<DownloadMovieModel>.from(json.decode(str).map((x) => DownloadMovieModel.fromJson(x)));

String DownloadMovieModelToJson(List<DownloadMovieModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DownloadMovieModel {
  String videoId;
  String title;
  String description;
  String genreName;
  String languageName;
  String bannerLink;
  String bannerType;
  String ratings;
  String videoLink;
  DownloadTaskStatus status;
  int progress;
  String taskId;
  String savedDir;

  DownloadMovieModel({
    required this.videoId,
    required this.title,
    required this.description,
    required this.genreName,
    required this.languageName,
    required this.bannerLink,
    required this.bannerType,
    required this.videoLink,
    required this.ratings,
    required this.status,
    required this.progress,
    required this.taskId,
    required this.savedDir,
  });

  factory DownloadMovieModel.fromJson(Map<String, dynamic> json) => DownloadMovieModel(
    videoId: json["video_id"],
    title: json["title"],
    description: json["description"],
    genreName: json["genre_name"],
    languageName: json["language_name"],
    bannerLink: json["banner_link"],
    bannerType: json["banner_type"],
    ratings: json["ratings"],
    videoLink: json["videoLink"],
    status: json["status"],
    progress: json["progress"],
    taskId: json["id"],
    savedDir: json["savedDirectory"],
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
    "videoLink": videoLink,
    "status": status,
    "id": taskId,
    "savedDirectory": savedDir,
  };
}
