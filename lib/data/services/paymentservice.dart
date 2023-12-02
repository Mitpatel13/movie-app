import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/planmodel.dart';
import 'package:shinestreamliveapp/data/models/registermodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/otpmodel.dart';
import '../models/tokenModel.dart';


class PaymentService {
  var dio = getIt<Api>().dio;
  Future tokenApi(String uid,String pid,String amount) async {
    try {
      var response = await dio.post(
          '/token_api?data={"user_id":'+uid+',"plan_id":'+pid+',"plan_amount":'+amount+'}');


      print(response.data);
      String str = response.data.replaceAll("\\","");
      String str1 = str.replaceAll('}}"', "}}");
      String strfinal = str1.replaceAll('"{', "{");
      print("final printinggggggggggg");
      print(strfinal);
      int i=0;
      if (response.statusCode == 200) {
        // if(response.data['RESPMSG'] == "User has not completed transaction."
        // ){
        //   Logger().e("USER nOT COMPLETE PAYMET");
        // }
        TokenModel _model = tokenModelFromJson(strfinal);
        return _model;
      }
    } on DioError catch (e) {
      log("Login Check Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future planDetails() async {

    try {
      var response = await dio.get(ApiEndPoints.planDetails);
      if (response.statusCode == 200) {
        List<PlanModel> _model = planModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }



}
