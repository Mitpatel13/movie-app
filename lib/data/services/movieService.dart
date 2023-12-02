import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/allmoviemodel.dart';
import '../models/homebannermodel.dart';
import '../models/moviepreviewmodel.dart';


class MovieService {
  var dio = getIt<Api>().dio;
  Future moviePreview(var jsonBody) async {

    try {
      var response = await dio.post(ApiEndPoints.moviePreview,data: jsonBody);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<MoviePreviewModel> _model = moviePreviewModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Movie Preview Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future allMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.allMovie);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<SearchModel> _model = searchModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("All Movie Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}