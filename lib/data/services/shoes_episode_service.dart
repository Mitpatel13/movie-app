import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/webseriesModel/episodesdatamodel.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../di/locator.dart';
import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/webseriesModel/webSeresdatamodel.dart';

class ShowsEpisodeService {
  var dio = getIt<Api>().dio;
  Future showsDataGet(FormData jsonData) async {
    try {
      var response = await dio.post(ApiEndPoints.showEpisodesApi,data: jsonData);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<WebSeriesDataModel> webSeriesList = webSeriesDataModelFromJson(response.data);

        // Assuming you expect a single item in the list, you can return the first one
        return webSeriesList.isNotEmpty ? webSeriesList.first : throw 'No data found';
      }


    } on DioError catch (e,t) {
      log("showsDataGet Error log : "+e.toString());
      log("showsDataGet Error Trace : "+t.toString());

      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future showsEpisodesGet(FormData jsonData) async {
    try {
      var response = await dio.post(ApiEndPoints.getEpisodeForShowsApi,data: jsonData);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<EpisodesDataModel> episodesList = episodesDataModelFromJson(response.data);
        AppLog.i(episodesList.map((e) => e.title));

        // Assuming you expect a single item in the list, you can return the first one
        return episodesList.isNotEmpty ? episodesList : throw 'No data found';
      }


    } on DioError catch (e,t) {
      log("showsEpisodesGet Error log : "+e.toString());
      log("showsEpisodesGet Error Trace : "+t.toString());

      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}