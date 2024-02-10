import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shinestreamliveapp/data/models/changepasswordmodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';


class ChangePasswordService {
  var dio = getIt<Api>().dio;
  Future changePassword(var jsonBody,context) async {

    try {
      var response = await dio.post(ApiEndPoints.changePassword,data: jsonBody);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<ChangePasswordModel> _model = changePasswordModelFromJson(response.data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_model[0].msg)));
        return _model;
      }


    } on DioError catch (e) {
      log("Change Password Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}