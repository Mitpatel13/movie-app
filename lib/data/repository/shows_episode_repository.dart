import 'dart:developer';
import 'package:dio/src/form_data.dart';
import '../../di/locator.dart';
import '../services/shoes_episode_service.dart';

class ShowsEpisodeSeriesRepository {
  var showsEpisodeService = getIt<ShowsEpisodeService>();
  Future<dynamic> showSeriesDataGet(FormData jsonData) async {
    try {
      var response = await showsEpisodeService.showsDataGet(jsonData);
      return response;
    } catch (e,t) {
      log("showSeriesDataGet  API EXCEPTION : $e");
      log("showSeriesDataGet  API TRACE : $t");
      throw e;
    }
  }
  Future<dynamic> showsEpisodesGet(FormData jsonData) async {
    try {
      var response = await showsEpisodeService.showsEpisodesGet(jsonData);
      return response;
    } catch (e,t) {
      log("showsEpisodesGet  API EXCEPTION : $e");
      log("showsEpisodesGet  API TRACE : $t");
      throw e;
    }
  }
}