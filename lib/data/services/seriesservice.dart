import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/seriesbannermodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/homebannermodel.dart';
import '../models/seriesmodel.dart';


class SeriesService {
  var dio = getIt<Api>().dio;
  Future seriesBanner() async {

    try {
      var response = await dio.get(ApiEndPoints.seriesBanner);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<SeriesBannerModel> _model = seriesBannerModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("seriesBanner Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future seriesList() async {

    try {
      var response = await dio.get(ApiEndPoints.seriesList);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<SeriesModel> _model = seriesModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("series List Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}