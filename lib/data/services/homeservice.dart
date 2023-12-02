import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';

import '../../../di/locator.dart';

import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';
import '../models/homebannermodel.dart';


class HomeService {
  var dio = getIt<Api>().dio;
  Future homeBanner() async {

    try {
      var response = await dio.get(ApiEndPoints.homeBanner);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<HomeBannerModel> _model = homeBannerModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Login Check Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future actionMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.actionMovie);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Login Check Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future classicMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.classicMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future comedyMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.comedyMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        Logger().d(_model.map((e) => e.title.toString()));
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future crimeMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.crimeMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        Logger().d(_model.map((e) => e.title.toString()));

        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future romanticMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.romanticMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future telugufavMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.telugufavMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future dramaMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.dramaMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future kidsMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.kidsMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future sportsMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.sportsMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future devotionalMovie() async {

    try {
      var response = await dio.get(ApiEndPoints.devotionalMovie);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future folkSongs() async {

    try {
      var response = await dio.get(ApiEndPoints.folksongs);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future oldIsGold() async {

    try {
      var response = await dio.get(ApiEndPoints.oldIsGold);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future bestHollywood() async {

    try {
      var response = await dio.get(ApiEndPoints.bestHollywood);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future bestSouth() async {

    try {
      var response = await dio.get(ApiEndPoints.bestSouth);
      if (response.statusCode == 200) {
        List<ActionMovieModel> _model = actionMovieModelFromJson(response.data);
        return _model;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }




}