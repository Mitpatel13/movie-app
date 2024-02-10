import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../../di/locator.dart';
import '../services/paymentservice.dart';
class PaymentRepository {
  var paymentService = getIt<PaymentService>();
  Future<dynamic> tokenApi(String uid,String pid,String amount) async {
    try {
      var response = await paymentService.tokenApi(uid,pid,amount);
      print("returning the response");
      return response;
    } catch (e,t) {
      log("Token Api EXCEPTION : $e");
      AppLog.w("Token Api TRACE : $t");
      throw e;
    }
  }
  Future<dynamic> callbackApiForPaytmResponse(FormData jsonBody) async {
    try {
      var response = await paymentService.callbackApiForPaytmResponse(jsonBody);
      print("returning the response");
      return response;
    } catch (e,t) {
      log("Token Api EXCEPTION : $e");
      AppLog.w("Token Api TRACE : $t");
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