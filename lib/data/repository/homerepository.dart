import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/policymodel.dart';
import 'package:shinestreamliveapp/data/services/homeservice.dart';

import '../../../di/locator.dart';
import '../services/loginservice.dart';

import '../exceptions/dioexceptions.dart';

class HomeRepository {
  // var loginService = getIt<LoginService>();
  var homeService = getIt<HomeService>();
  Future<dynamic> homeBanner() async {
    try {
      var response = await homeService.homeBanner();
      return response;
    } catch (e) {
      log("Home Banner API EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> actionMovie() async {
    try {
      var response = await homeService.actionMovie();
      return response;
    } catch (e) {
      log("Action Movie EXCEPTION : $e");
      throw e;
    }
  }

  Future<dynamic> classicMovie() async {
    try {
      var response = await homeService.classicMovie();
      return response;
    } catch (e) {
      log("classicMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> comedyMovie() async {
    try {
      var response = await homeService.comedyMovie();
      return response;
    } catch (e) {
      log("comedyMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> crimeMovie() async {
    try {
      var response = await homeService.crimeMovie();
      return response;
    } catch (e) {
      log("crimeMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> romanticMovie() async {
    try {
      var response = await homeService.romanticMovie();
      return response;
    } catch (e) {
      log("romanticMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> telugufavMovie() async {
    try {
      var response = await homeService.telugufavMovie();
      return response;
    } catch (e) {
      log("telugufavMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> dramaMovie() async {
    try {
      var response = await homeService.dramaMovie();
      return response;
    } catch (e) {
      log("dramaMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> kidsMovie() async {
    try {
      var response = await homeService.kidsMovie();
      return response;
    } catch (e) {
      log("kidsMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> sportsMovie() async {
    try {
      var response = await homeService.sportsMovie();
      return response;
    } catch (e) {
      log("sportsMovie EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> devotionalMovie() async {
    try {
      var response = await homeService.devotionalMovie();
      return response;
    } catch (e) {
      log("devotionalMovie EXCEPTION : $e");
      throw e;
    }
  }

  Future<dynamic> folkSongs() async {
    try {
      var response = await homeService.folkSongs();
      return response;
    } catch (e) {
      log("folkSongs EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> oldIsGold() async {
    try {
      var response = await homeService.oldIsGold();
      return response;
    } catch (e) {
      log("oldIsGold EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> bestHollywood() async {
    try {
      var response = await homeService.bestHollywood();
      return response;
    } catch (e) {
      log("bestHollywood EXCEPTION : $e");
      throw e;
    }
  }
  Future<dynamic> bestSouth() async {
    try {
      var response = await homeService.bestSouth();
      return response;
    } catch (e) {
      log("bestSouth EXCEPTION : $e");
      throw e;
    }
  }






}