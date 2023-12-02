// To parse this JSON data, do
//
//     final checkLoginModel = checkLoginModelFromJson(jsonString);

import 'dart:convert';

List<CheckLoginModel> checkLoginModelFromJson(String str) => List<CheckLoginModel>.from(json.decode(str).map((x) => CheckLoginModel.fromJson(x)));

String checkLoginModelToJson(List<CheckLoginModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckLoginModel {
  CheckLoginModel({
    required this.msg,
    required this.status,
    required this.usersLogin,
  });

  String msg;
  bool status;
  List<UsersLogin> usersLogin;

  factory CheckLoginModel.fromJson(Map<String, dynamic> json) => CheckLoginModel(
    msg: json["msg"],
    status: json["status"],
    usersLogin: List<UsersLogin>.from(json["users_login"].map((x) => UsersLogin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "users_login": List<dynamic>.from(usersLogin.map((x) => x.toJson())),
  };
}

class UsersLogin {
  UsersLogin({
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.email,
  });

  String userId;
  String name;
  String mobileNo;
  String email;

  factory UsersLogin.fromJson(Map<String, dynamic> json) => UsersLogin(
    userId: json["user_id"],
    name: json["name"],
    mobileNo: json["mobile_no"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "mobile_no": mobileNo,
    "email": email,
  };
}
