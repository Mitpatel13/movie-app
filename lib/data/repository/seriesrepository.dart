import 'dart:developer';

import '../../../di/locator.dart';
import '../services/seriesservice.dart';

class SeriesRepository {
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
    } catch (e,t) {
      log("Series List API EXCEPTION : $e");
      log("Series List API TRACE : $t");
      throw e;
    }
  }
}