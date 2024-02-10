// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  String? videoId;
  String? title;
  String? thumbnail;

  SearchModel({
     this.videoId,
     this.title,
     this.thumbnail,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    videoId: json["video_id"]??"",
    title: json["title"]??"",
    thumbnail: json["thumbnail"]??"",
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "thumbnail": thumbnail,
  };
}
