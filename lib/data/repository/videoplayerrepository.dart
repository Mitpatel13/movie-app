import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/checkloginmodel.dart';
import 'package:shinestreamliveapp/data/models/policymodel.dart';
import 'package:shinestreamliveapp/data/services/homeservice.dart';
import 'package:shinestreamliveapp/data/services/videoplayerservice.dart';

import '../../../di/locator.dart';

class VideoPlayerRepository {
  var videoPlayer = getIt<VideoPlayerService>();
  Future<dynamic> getVideo(var jsonBody) async {
    try {
      var response = await videoPlayer.getVideo(jsonBody);
      return response;
    } catch (e) {
      log("Video Player API EXCEPTION : $e");
      throw e;
    }
  }
}