import 'dart:developer';
import '../../../di/locator.dart';
import '../services/shows_service.dart';

class ShowsRepository {
  var showsService = getIt<ShowsService>();
  Future<dynamic> showsBanner() async {
    try {
      var response = await showsService.showsBanner();
      return response;
    } catch (e) {
      log("Shows Banner API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> showsList() async {
    try {
      var response = await showsService.showsList();
      return response;
    } catch (e,t) {
      log("Shows List API EXCEPTION : $e");
      log("Shows List API TRACE : $t");
      throw e;
    }
  }
}