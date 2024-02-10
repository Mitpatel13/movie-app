import 'dart:developer';
import 'package:logger/logger.dart';
import '../../../di/locator.dart';
import '../services/movieService.dart';

class MovieRepository {
  var movieService = getIt<MovieService>();
  Future<dynamic> moviePreview(var jsonBody) async {
    try {
      var response = await movieService.moviePreview(jsonBody);
      return response;
    } catch (e,t) {
      log("Movie Preview API EXCEPTION : $e");
      Logger().e("ERROR:${e} === TRACE ::${t}");
      throw e;
    }
  }
  Future<dynamic> allMovie() async {
    try {
      var response = await movieService.allMovie();
      return response;
    } catch (e) {
      log("Movie ALl API EXCEPTION : $e");
      throw e;
    }
  }
}