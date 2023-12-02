import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/data/models/homebannermodel.dart';

import '../../di/locator.dart';
import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';

class LanguageMovieService {


  var dio = getIt<Api>().dio;

  Future languageAPi({required int jsonBody}) async {

    try {
      Logger().f("language api call");
      var response = await dio.get(ApiEndPoints.languageApi,queryParameters: {"language_id":jsonBody}
      // {"language_id":2}
      );
      if (response.statusCode == 200) {
        // Logger().d(response.data);
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e,t) {
      Logger().e(e);
      Logger().e(t);
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}