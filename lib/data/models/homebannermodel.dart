import 'dart:convert';

List<HomeBannerModel> homeBannerModelFromJson(String str) => List<HomeBannerModel>.from(json.decode(str).map((x) => HomeBannerModel.fromJson(x)));

String homeBannerModelToJson(List<HomeBannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeBannerModel {
  HomeBannerModel({
     this.videoId,
     this.title,
     this.thumbnail,
     this.payPerView,
     this.videoPrice,
  });

  String? videoId;
  String? title;
  String? thumbnail;
  String? payPerView;
  String? videoPrice;

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) => HomeBannerModel(
    videoId: json["video_id"]??"",
    title: json["title"]??"",
    thumbnail: json["thumbnail"]??"",
    payPerView: json["pay_per_view"]??"",
    videoPrice: json["video_price"]??"",
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "thumbnail": thumbnail,
    "pay_per_view": payPerView,
    "video_price": videoPrice,
  };
}

// To parse this JSON data, do
//
//     final actionMovieModel = actionMovieModelFromJson(jsonString);



List<ActionMovieModel> actionMovieModelFromJson(String str) => List<ActionMovieModel>.from(json.decode(str).map((x) => ActionMovieModel.fromJson(x)));

String actionMovieModelToJson(List<ActionMovieModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActionMovieModel {
  ActionMovieModel({
     this.videoId,
     this.title,
     this.thumbnail,
     this.payPerView,
     this.videoPrice,
  });

  String? videoId;
  String? title;
  String? thumbnail;
  String? payPerView;
  String? videoPrice;

  factory ActionMovieModel.fromJson(Map<String, dynamic> json) => ActionMovieModel(
    videoId: json["video_id"]??"",
    title: json["title"]??"",
    thumbnail: json["thumbnail"]??"",
    payPerView: json["pay_per_view"]??"",
    videoPrice: json["video_price"]??"",
  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "title": title,
    "thumbnail": thumbnail,
    "pay_per_view": payPerView,
    "video_price": videoPrice,
  };
}

