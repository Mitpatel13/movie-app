// To parse this JSON data, do
//
//     final policyModel = policyModelFromJson(jsonString);

import 'dart:convert';

List<PolicyModel> policyModelFromJson(String str) => List<PolicyModel>.from(json.decode(str).map((x) => PolicyModel.fromJson(x)));

String policyModelToJson(List<PolicyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PolicyModel {
  PolicyModel({
    required this.privacyPolicyId,
    required this.policy,
  });

  String privacyPolicyId;
  String policy;

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
    privacyPolicyId: json["privacy_policy_id"],
    policy: json["policy"],
  );

  Map<String, dynamic> toJson() => {
    "privacy_policy_id": privacyPolicyId,
    "policy": policy,
  };
}
