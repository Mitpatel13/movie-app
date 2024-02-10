import 'dart:developer';
import 'package:dio/src/form_data.dart';
import '../../di/locator.dart';
import '../../utils/app_log.dart';
import '../services/episodeservice.dart';

class WebEpisodeSeriesRepository {
  var webEpisodeService = getIt<WebSeriesEpisodeService>();
  Future<dynamic> webSeriesDataGet(FormData jsonData) async {
    try {
      var response = await webEpisodeService.webSeriesDataGet(jsonData);
      AppLog.e(response);
      return response;
    } catch (e,t) {
      log("webSeriesDataGet  API EXCEPTION : $e");
      log("webSeriesDataGet  API TRACE : $t");
      throw e;
    }
  }
  Future<dynamic> episodesGet(FormData jsonData) async {
    try {
      var response = await webEpisodeService.episodesGet(jsonData);
      return response;
    } catch (e,t) {
      log("episodesGet  API EXCEPTION : $e");
      log("episodesGet  API TRACE : $t");
      throw e;
    }
  }
}