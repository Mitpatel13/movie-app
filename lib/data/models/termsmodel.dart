// To parse this JSON data, do
//
//     final termsModel = termsModelFromJson(jsonString);

import 'dart:convert';

List<TermsModel> termsModelFromJson(String str) => List<TermsModel>.from(json.decode(str).map((x) => TermsModel.fromJson(x)));

String termsModelToJson(List<TermsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermsModel {
  TermsModel({
    required this.termId,
    required this.terms,
  });

  String termId;
  String terms;

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    termId: json["term_id"],
    terms: json["terms"],
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "terms": terms,
  };
}
