import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/registermodel.dart';
import 'package:shinestreamliveapp/ui/dashboard/homescreen.dart';

import '../../../di/locator.dart';
import 'package:http/http.dart' as http;
import '../../ui/widget_components/bottomnavbar.dart';
import '../../utils/shared_prefs.dart';
import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/otpmodel.dart';


class LoginService {
  var dio = getIt<Api>().dio;
  Future checkLogin(var jsonBody,context) async {

    try {
      var response = await dio.post(ApiEndPoints.checkLogin,data: jsonBody);
      print("Printing the data of the response");
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // SnackBar a= SnackBar(content: Text("${response.data['msg']}"));

        // Logger().w(response.data['msg'].toString());
        // ScaffoldMessenger.of(context).showSnackBar(a);
        List<CheckLoginModel> _model = checkLoginModelFromJson(response.data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_model[0].msg)));
        Logger().d(_model[0].msg);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // print(response.data["user_id"]);
        print(_model[0].usersLogin[0].userId);
        prefs.setString(SharedConstants.udid,_model[0].usersLogin[0].userId);
        prefs.setString(SharedConstants.mobileNumber,_model[0].usersLogin[0].mobileNo);
        prefs.setString(SharedConstants.subScription,_model[0].status.toString());
        prefs.setString(SharedConstants.userName,_model[0].usersLogin[0].name.toString());

        Logger().d("USER ${_model[0].usersLogin[0].name.toString()}");
        Logger().d("USER LOGIN SET");

        return _model;
      }



    } on DioError catch (e) {
      log("Login Check Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future register(var jsonBody,context) async {

    try {
      var response = await dio.post(ApiEndPoints.register,data: jsonBody);
      print(response.data);
      if (response.statusCode == 200) {
        List<RegisterModel> _model = registerModelFromJson(response.data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_model[0].msg)));
        Logger().d(_model[0].msg);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // print(response.data["user_id"]);
        print(_model[0].users[0].userId);
        prefs.setString(SharedConstants.udid,_model[0].users[0].userId.toString());
        prefs.setString(SharedConstants.udid,_model[0].users[0].mobileNo.toString());
        prefs.setString(SharedConstants.userName,_model[0].users[0].name.toString());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigation(index: 0,),), (route) => false);


        return _model;
      }


    } on DioError catch (e) {
      log("Register Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future otpLoad(var jsonBody) async {
    Logger().d(jsonDecode(jsonBody));
    // 2c1e3d96-f2e0-11ed-addf-0200cd936042
    //My api key 553761c5-883c-11ee-8cbb-0200cd936042
    try {
      final response = await http.get(Uri.parse(
          'https://2factor.in/API/V1/2c1e3d96-f2e0-11ed-addf-0200cd936042/SMS/+91${jsonBody}/AUTOGEN'));
      // var response = await dio.post(ApiEndPoints.otp);
      print(response.body);
      if (response.statusCode == 200) {
        TwoFactorOtpModel _model = twoFactorOtpModelFromJson(response.body);
        return _model;
      }
    } on DioError catch (e) {
      log("OTP Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future verifyOtp(var sessionId,var otp) async {

    try {
      final response = await
      http.get(Uri.parse(
          'https://2factor.in/API/V1/2c1e3d96-f2e0-11ed-addf-0200cd936042/SMS/VERIFY/'+sessionId+'/'+otp+''));
      // var response = await dio.post(ApiEndPoints.otp);
      print(response.body);
      if (response.statusCode == 200) {
        TwoFactorOtpModel _model = twoFactorOtpModelFromJson(response.body);
        return _model;
      }
      if (response.statusCode == 400) {
        TwoFactorOtpModel _model = twoFactorOtpModelFromJson(response.body);
        return _model;
      }
    } on DioError catch (e) {
      log("OTP Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}