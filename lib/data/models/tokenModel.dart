// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));


String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  Res res;
  String orderId;
  int amount;

  TokenModel({
    required this.res,
    required this.orderId,
    required this.amount,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    res: Res.fromJson(json["res"]),
    orderId: json["order_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "res": res.toJson(),
    "order_id": orderId,
    "amount": amount,
  };
}

class Res {
  Head head;
  Body body;

  Res({
    required this.head,
    required this.body,
  });

  factory Res.fromJson(Map<String, dynamic> json) => Res(
    head: Head.fromJson(json["head"]),
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "head": head.toJson(),
    "body": body.toJson(),
  };
}

class Body {
  ResultInfo resultInfo;
  String txnToken;
  bool isPromoCodeValid;
  bool authenticated;

  Body({
    required this.resultInfo,
    required this.txnToken,
    required this.isPromoCodeValid,
    required this.authenticated,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    resultInfo: ResultInfo.fromJson(json["resultInfo"]),
    txnToken: json["txnToken"],
    isPromoCodeValid: json["isPromoCodeValid"],
    authenticated: json["authenticated"],
  );

  Map<String, dynamic> toJson() => {
    "resultInfo": resultInfo.toJson(),
    "txnToken": txnToken,
    "isPromoCodeValid": isPromoCodeValid,
    "authenticated": authenticated,
  };
}

class ResultInfo {
  String resultStatus;
  String resultCode;
  String resultMsg;

  ResultInfo({
    required this.resultStatus,
    required this.resultCode,
    required this.resultMsg,
  });

  factory ResultInfo.fromJson(Map<String, dynamic> json) => ResultInfo(
    resultStatus: json["resultStatus"],
    resultCode: json["resultCode"],
    resultMsg: json["resultMsg"],
  );

  Map<String, dynamic> toJson() => {
    "resultStatus": resultStatus,
    "resultCode": resultCode,
    "resultMsg": resultMsg,
  };
}

class Head {
  String responseTimestamp;
  String version;
  String signature;

  Head({
    required this.responseTimestamp,
    required this.version,
    required this.signature,
  });

  factory Head.fromJson(Map<String, dynamic> json) => Head(
    responseTimestamp: json["responseTimestamp"],
    version: json["version"],
    signature: json["signature"],
  );

  Map<String, dynamic> toJson() => {
    "responseTimestamp": responseTimestamp,
    "version": version,
    "signature": signature,
  };
}