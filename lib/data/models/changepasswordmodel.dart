// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

List<ChangePasswordModel> changePasswordModelFromJson(String str) => List<ChangePasswordModel>.from(json.decode(str).map((x) => ChangePasswordModel.fromJson(x)));

String changePasswordModelToJson(List<ChangePasswordModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangePasswordModel {
  String msg;
  bool status;

  ChangePasswordModel({
    required this.msg,
    required this.status,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
  };
}
