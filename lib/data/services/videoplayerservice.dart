import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shinestreamliveapp/data/models/videoplayermodel.dart';

import '../../di/locator.dart';
import '../api.dart';
import '../apiendpoints.dart';
import '../exceptions/dioexceptions.dart';


class VideoPlayerService {
  var dio = getIt<Api>().dio;
  Future getVideo(var jsonBody) async {

    try {
      var response = await dio.post(ApiEndPoints.videoPlayer,data: jsonBody);
      print("Printing the data of the response");
      print(response.data);
      if (response.statusCode == 200) {
        List<VideoPlayerModel> _model = videoPlayerModelFromJson(response.data);
        return _model;
      }


    } on DioError catch (e) {
      log("Video Player Error log : "+e.toString());
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}