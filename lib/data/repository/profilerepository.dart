import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/policymodel.dart';
import 'package:shinestreamliveapp/data/services/homeservice.dart';

import '../../../di/locator.dart';
import '../services/loginservice.dart';

import '../exceptions/dioexceptions.dart';
import '../services/profileservice.dart';

class ProfileRepository {
  // var loginService = getIt<LoginService>();
  var profileService = getIt<ProfileService>();
  Future<dynamic> getRefund() async {
    try {
      var response = await profileService.getRefund();
      return response;
    } catch (e) {
      log("Get Refund API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> getPolicy() async {
    try {
      var response = await profileService.getPolicy();
      return response;
    } catch (e) {
      log("Get Policy API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> getAbout() async {
    try {
      var response = await profileService.getAbout();
      return response;
    } catch (e) {
      log("Get About API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> getTerms() async {
    try {
      var response = await profileService.getTerms();
      return response;
    } catch (e) {
      log("Get Terms API EXCEPTION : $e");
      throw e;
    }
  }
}