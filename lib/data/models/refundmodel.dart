// To parse this JSON data, do
//
//     final refundModel = refundModelFromJson(jsonString);

import 'dart:convert';

List<RefundModel> refundModelFromJson(String str) => List<RefundModel>.from(json.decode(str).map((x) => RefundModel.fromJson(x)));

String refundModelToJson(List<RefundModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RefundModel {
  RefundModel({
    required this.refundId,
    required this.refund,
  });

  String refundId;
  String refund;

  factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
    refundId: json["refund_id"],
    refund: json["refund"],
  );

  Map<String, dynamic> toJson() => {
    "refund_id": refundId,
    "refund": refund,
  };
}
