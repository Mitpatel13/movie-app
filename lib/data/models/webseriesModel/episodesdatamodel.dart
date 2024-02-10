// To parse this JSON data, do
//
//     final episodesDataModel = episodesDataModelFromJson(jsonString);

import 'dart:convert';

List<EpisodesDataModel> episodesDataModelFromJson(String str) => List<EpisodesDataModel>.from(json.decode(str).map((x) => EpisodesDataModel.fromJson(x)));

String episodesDataModelToJson(List<EpisodesDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EpisodesDataModel {
  final String? episodeId;
  final String? title;
  final String? thumbnail;
  final String? duration;
  final String? descriptions;
  final String? fileName;
  final String? freeEpisode;

  EpisodesDataModel({
    this.episodeId,
    this.title,
    this.thumbnail,
    this.duration,
    this.descriptions,
    this.fileName,
    this.freeEpisode,
  });

  factory EpisodesDataModel.fromJson(Map<String, dynamic> json) => EpisodesDataModel(
    episodeId: json["episode_id"]??"",
    title: json["title"]??"",
    thumbnail: json["thumbnail"]??"",
    duration: json["duration"]??"",
    descriptions: json["descriptions"]??"",
    fileName: json["file_name"]??"",
    freeEpisode: json["free_episode"]??"",
  );

  Map<String, dynamic> toJson() => {
    "episode_id": episodeId,
    "title": title,
    "thumbnail": thumbnail,
    "duration": duration,
    "descriptions": descriptions,
    "file_name": fileName,
    "free_episode": freeEpisode,
  };
}
