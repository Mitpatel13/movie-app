import 'dart:convert';
import 'dart:developer';

import '../../../di/locator.dart';
import '../services/loginservice.dart';

class LoginRepository {
  var loginService = getIt<LoginService>();
  Future<dynamic> checkLogin(var jsonBody,context) async {
    try {
      var response = await loginService.checkLogin(jsonBody,context);

      print("returning the response");
      return response;
    } catch (e) {
      log("Login API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> register(var jsonBody,context) async {
    try {
      var response = await loginService.register(jsonBody,context);


      return response;
    } catch (e) {
      log("Register API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> otpLoad(var jsonBody) async {
    try {
      var response = await loginService.otpLoad(jsonBody);

      return response;
    } catch (e) {
      log("OTP API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> verifyOtp(var session,var otp) async {
    try {
      var response = await loginService.verifyOtp(session,otp);


      return response;
    } catch (e) {
      log("OTP API EXCEPTION : $e");
      throw e;
    }
  }
}