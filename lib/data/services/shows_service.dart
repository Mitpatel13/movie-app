import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/seriesbannermodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/seriesmodel.dart';


class ShowsService {
  var dio = getIt<Api>().dio;
  Future showsBanner() async {

    try {
      var response = await dio.get(ApiEndPoints.showsBannerApi);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<SeriesBannerModel> _model = seriesBannerModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Shows Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future showsList() async {

    try {
      print("==== Shows list get data calling ");
      var response = await dio.get(ApiEndPoints.dynamicShowApi);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<SeriesModel> _model = seriesModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Shows List Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}