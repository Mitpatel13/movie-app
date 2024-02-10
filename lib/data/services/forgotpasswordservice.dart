import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/forgotpasswordmodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';

class ForgotPasswordService {
  var dio = getIt<Api>().dio;
  Future forgotPassword(var jsonBody) async {

    try {
      var response = await dio.post(ApiEndPoints.forgotPassword,data: jsonBody);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<ForgotPasswordModel> _model = forgotPasswordModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Forgot Password Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}