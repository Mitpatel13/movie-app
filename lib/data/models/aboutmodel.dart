// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

List<AboutModel> aboutModelFromJson(String str) => List<AboutModel>.from(json.decode(str).map((x) => AboutModel.fromJson(x)));

String aboutModelToJson(List<AboutModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AboutModel {
  AboutModel({
    required this.aboutId,
    required this.about,
  });

  String aboutId;
  String about;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    aboutId: json["about_id"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "about_id": aboutId,
    "about": about,
  };
}
