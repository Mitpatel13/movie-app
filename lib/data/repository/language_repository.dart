import 'dart:developer';

import 'package:shinestreamliveapp/data/services/language_movie_service.dart';

import '../../di/locator.dart';

class LanguageByMovieRepository {
  var movieService = getIt<LanguageMovieService>();
  Future<dynamic> getMovieByLanguage({required int jsonBody}) async {
    try {
      var response = await movieService.languageAPi(jsonBody: jsonBody);
      return response;
    } catch (e) {
      log("Movie Preview API EXCEPTION : $e");
      throw e;
    }
  }
}