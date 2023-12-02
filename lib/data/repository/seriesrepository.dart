import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/policymodel.dart';
import 'package:shinestreamliveapp/data/services/homeservice.dart';

import '../../../di/locator.dart';
import '../services/loginservice.dart';

import '../exceptions/dioexceptions.dart';
import '../services/seriesservice.dart';

class SeriesRepository {
  // var loginService = getIt<LoginService>();
  var seriesService = getIt<SeriesService>();
  Future<dynamic> seriesBanner() async {
    try {
      var response = await seriesService.seriesBanner();
      return response;
    } catch (e) {
      log("Series Banner API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> seriesList() async {
    try {
      var response = await seriesService.seriesList();
      return response;
    } catch (e) {
      log("Series List API EXCEPTION : $e");
      throw e;
    }
  }
}