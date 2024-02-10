import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/planmodel.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/tokenModel.dart';


class PaymentService {
  var dio = getIt<Api>().dio;
  Future tokenApi(String uid,String pid,String amount) async {
    FormData formData =  FormData.fromMap({
      "user_id": uid,
      "plan_amount": amount,
      "plan_id": pid,
    });
    try {
      var response = await dio.post(
        ApiEndPoints.tokenApi2,

          data: formData
          // '/token_api?data={"user_id":'+uid+',"plan_id":'+pid+',"plan_amount":'+amount+'}'
      );
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);

          String str = response.data.replaceAll("\\","");
          String str1 = str.replaceAll('}}"', "}}");
          String strfinal = str1.replaceAll('"{', "{");
          print("final printinggggggggggg");
          print(strfinal);
          TokenModel _model = tokenModelFromJson(strfinal);
          return _model;
      }


    } on DioError catch (e) {
      log("Movie Preview Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future callbackApiForPaytmResponse(FormData jsonBody) async {
    try {
      var response = await dio.post(
        ApiEndPoints.callbackApiForPaytmResponse,

          data: jsonBody
      );
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        AppLog.d(jsonBody.fields.map((field) {
          print('Field name: ${field.key}');
          print('Field value: ${field.value}');
        }));
        AppLog.w("THIS UPPER RESPOSE AFTER SEND SUVESSFUL RESPONSE TO API");

        AppLog.f("RESPONSE FROM SERVER${response.data}");
        AppLog.d("datasend sucess");
        //   TokenModel _model = tokenModelFromJson(strfinal);
        //   return _model;
      }


    } on DioError catch (e) {
      log("Movie Preview Error log : "+e.toString());
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
