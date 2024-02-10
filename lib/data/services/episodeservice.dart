import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/webseriesModel/episodesdatamodel.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../di/locator.dart';
import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/webseriesModel/webSeresdatamodel.dart';

class WebSeriesEpisodeService {
  var dio = getIt<Api>().dio;
  Future webSeriesDataGet(FormData jsonData) async {
    try {
      var response = await dio.post(ApiEndPoints.seriesEpisodesApi,data: jsonData);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<WebSeriesDataModel> webSeriesList = webSeriesDataModelFromJson(response.data);

        // Assuming you expect a single item in the list, you can return the first one
        return webSeriesList.isNotEmpty ? webSeriesList.first : throw 'No data found';
      }


    } on DioError catch (e,t) {
      log("webSeriesDataGet Error log : "+e.toString());
      log("webSeriesDataGet Error Trace : "+t.toString());

      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future episodesGet(FormData jsonData) async {
    try {
      var response = await dio.post(ApiEndPoints.sendeindSeasonIdAndWedIdForPertuclerEpisodeDataApi,data: jsonData);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<EpisodesDataModel> episodesList = episodesDataModelFromJson(response.data);
        AppLog.i(episodesList.map((e) => e.title));

        // Assuming you expect a single item in the list, you can return the first one
        return episodesList.isNotEmpty ? episodesList : throw 'No data found';
      }


    } on DioError catch (e,t) {
      log("webSeriesDataGet Error log : "+e.toString());
      log("webSeriesDataGet Error Trace : "+t.toString());

      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}