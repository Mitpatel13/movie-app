import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/policymodel.dart';

import '../../../di/locator.dart';
import '../services/loginservice.dart';

import '../exceptions/dioexceptions.dart';
import '../services/paymentservice.dart';
class PaymentRepository {
  var paymentService = getIt<PaymentService>();
  Future<dynamic> tokenApi(String uid,String pid,String amount) async {
    try {
      var response = await paymentService.tokenApi(uid,pid,amount);
      print("returning the response");
      return response;
    } catch (e) {
      log("Token Api EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> planDetails() async {
    try {
      var response = await paymentService.planDetails();
      return response;
    }catch (e) {
      log("planDetails API EXCEPTION : $e");
      throw e;
    }
  }
}