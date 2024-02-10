import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/aboutmodel.dart';
import 'package:shinestreamliveapp/data/models/refundmodel.dart';
import 'package:shinestreamliveapp/data/models/termsmodel.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/policymodel.dart';


class ProfileService {
  var dio = getIt<Api>().dio;
  Future logoutDeviceDecrement(var jsonBody,context) async {

    try {
      var response = await dio.post(ApiEndPoints.logoutDeviceDecrement,data: jsonBody);
      print("Printing the data of the response");
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Logout Successfully")));
        AppLog.d("USER LOGOUT SUCCESS");

        return response;
      }



    } on DioException catch (e,t) {
      log("Login Check Error log : "+e.toString());
      log("Login Check Error log : "+t.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future getRefund() async {

    try {
      var response = await dio.get(ApiEndPoints.getRefund);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<RefundModel> _model = refundModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Refund Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future getPolicy() async {

    try {
      var response = await dio.get(ApiEndPoints.getPolicy);
      if (response.statusCode == 200) {
        List<PolicyModel> _model = policyModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      log("Policy Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future getAbout() async {

    try {
      var response = await dio.get(ApiEndPoints.getAbout);
      if (response.statusCode == 200) {
        List<AboutModel> _model = aboutModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      log("About Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future getTerms() async {

    try {
      var response = await dio.get(ApiEndPoints.getTerms);
      if (response.statusCode == 200) {
        List<TermsModel> _model = termsModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      log("Terms Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}