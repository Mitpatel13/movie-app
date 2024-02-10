import 'dart:developer';

import '../../../di/locator.dart';
import '../services/profileservice.dart';

class ProfileRepository {
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
  Future<dynamic> logoutDeviceDecrement(jsonBody,context) async {
    try {
      var response = await profileService.logoutDeviceDecrement(jsonBody, context);
      return response;
    } catch (e,t) {
      log("Get LOgout Decrement API EXCEPTION : $e");
      log("Get LOgout Decrement API TRACE : $t");
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