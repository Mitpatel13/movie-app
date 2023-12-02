// To parse this JSON data, do
//
//     final planModel = planModelFromJson(jsonString);

import 'dart:convert';

List<PlanModel> planModelFromJson(String str) => List<PlanModel>.from(json.decode(str).map((x) => PlanModel.fromJson(x)));

String planModelToJson(List<PlanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanModel {
  String planId;
  String planName;
  String planDays;
  String planAmount;

  PlanModel({
    required this.planId,
    required this.planName,
    required this.planDays,
    required this.planAmount,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
    planId: json["plan_id"],
    planName: json["plan_name"],
    planDays: json["plan_days"],
    planAmount: json["plan_amount"],
  );

  Map<String, dynamic> toJson() => {
    "plan_id": planId,
    "plan_name": planName,
    "plan_days": planDays,
    "plan_amount": planAmount,
  };
}
