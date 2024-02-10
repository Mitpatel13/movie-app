// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

List<RegisterModel> registerModelFromJson(String str) => List<RegisterModel>.from(json.decode(str).map((x) => RegisterModel.fromJson(x)));

String registerModelToJson(List<RegisterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterModel {
  RegisterModel({
    required this.msg,
    required this.status,
    required this.users,
  });

  String msg;
  bool status;
  List<User> users;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    msg: json["msg"],
    status: json["status"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  User({
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.userLogin,
    required this.subscriber,
  });

  int userId;
  String name;
  String mobileNo;
  String userLogin;
  String subscriber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    name: json["name"],
    mobileNo: json["mobile_no"],
    userLogin: json["user_login"],
    subscriber: json["subscriber"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "mobile_no": mobileNo,
    "user_login": userLogin,
    "subscriber": subscriber,
  };
}
