// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

List<ForgotPasswordModel> forgotPasswordModelFromJson(String str) => List<ForgotPasswordModel>.from(json.decode(str).map((x) => ForgotPasswordModel.fromJson(x)));

String forgotPasswordModelToJson(List<ForgotPasswordModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForgotPasswordModel {
  String msg;
  bool status;
  String otpNo;

  ForgotPasswordModel({
    required this.msg,
    required this.status,
    required this.otpNo,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    msg: json["msg"],
    status: json["status"],
    otpNo: json["otp_no"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "otp_no": otpNo,
  };
}
