// To parse this JSON data, do
//
//     final videoPlayerModel = videoPlayerModelFromJson(jsonString);

import 'dart:convert';

List<VideoPlayerModel> videoPlayerModelFromJson(String str) => List<VideoPlayerModel>.from(json.decode(str).map((x) => VideoPlayerModel.fromJson(x)));

String videoPlayerModelToJson(List<VideoPlayerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoPlayerModel {
  String msg;
  bool status;
  List<VideoPlayer1> videoPlayer;

  VideoPlayerModel({
    required this.msg,
    required this.status,
    required this.videoPlayer,
  });

  factory VideoPlayerModel.fromJson(Map<String, dynamic> json) => VideoPlayerModel(
    msg: json["msg"],
    status: json["status"],
    videoPlayer: List<VideoPlayer1>.from(json["video player"].map((x) => VideoPlayer1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "video player": List<dynamic>.from(videoPlayer.map((x) => x.toJson())),
  };
}

class VideoPlayer1 {
  String videoId;
  String title;
  String videoLink;

  VideoPlayer1({
    required this.videoId,
    required this.title,
    required this.videoLink,
  });

  factory VideoPlayer1.fromJson(Map<String, dynamic> json) => VideoPlayer1(
    videoId: json["video_id"],
    title: json["title"],
    videoLink: json["video_link"],
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "video_link": videoLink,
  };
}
