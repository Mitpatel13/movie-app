// To parse this JSON data, do
//
//     final twoFactorOtpModel = twoFactorOtpModelFromJson(jsonString);

import 'dart:convert';

TwoFactorOtpModel twoFactorOtpModelFromJson(String str) => TwoFactorOtpModel.fromJson(json.decode(str));

String twoFactorOtpModelToJson(TwoFactorOtpModel data) => json.encode(data.toJson());

class TwoFactorOtpModel {
  String status;
  String details;

  TwoFactorOtpModel({
    required this.status,
    required this.details,
  });

  factory TwoFactorOtpModel.fromJson(Map<String, dynamic> json) => TwoFactorOtpModel(
    status: json["Status"],
    details: json["Details"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Details": details,
  };
}
