import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/payment/payment_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/vidoeplayer_cubit/videoplayer_cubit.dart';
import 'package:shinestreamliveapp/data/api.dart';
import 'package:shinestreamliveapp/data/models/moviepreviewmodel.dart';
import 'package:shinestreamliveapp/ui/widget_components/catched_image.dart';
import 'package:shinestreamliveapp/ui/payment/payment.dart';

import '../../basescreen/base_screen.dart';
import '../../cubit_bloc/download_data/download_bloc.dart';
import '../../data/models/videoplayermodel.dart';
import '../../data/repository/videoplayerrepository.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../../video_library/new_movie_player.dart';
import '../widget_components/app_bar_components.dart';
import 'package:path_provider/path_provider.dart';

class MovieDetails extends StatefulWidget {
  String videoId;
  MovieDetails(this.videoId, {super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends BaseScreen<MovieDetails> {
  String result = "";

  late List<MoviePreviewModel> movieModel = [];
  late List<VideoPlayerModel> videoModel = [];
  var movieCubit = getIt<MovieCubit>();
  var videoCubit = getIt<VideoplayerCubit>();
  final videoPlayer = getIt<VideoPlayerRepository>();
  final downloadCubit = getIt<DownloadCubit>();

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  String? userID;
  String? isSubScriber;
  void initializeFFmpeg() async {
  }
  @override
  void initState() {
    initializeFFmpeg();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("${SharedConstants.udid}");
    isSubScriber = prefs.getString("${SharedConstants.subScription}");
    Logger().f(
        "RECIVED VIDEO ID::${widget.videoId} :: subcriber== ${isSubScriber}");
    FormData jsonBody = FormData.fromMap({"video_id": widget.videoId});
    movieCubit.moviePreview(jsonBody);
    super.initState();
  }

  callInit() async {
    print("=================FLUTTER DOWNLOER INIT CALL ========");
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  }

  back() async {
    await movieCubit.allMovie();
  }

  final List<String> videoUrls = [
    'https://crm.assastech.site/video/videoplayback.m3u8',
    'https://crm.assastech.site/video/videoplayback.m3u8'
    // 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    // "https://file-examples.com/wp-content/storage/2017/04/file_example_MP4_480_1_5MG.mp4"
  ];


  double downloadProgress = 0.0;
  bool isDownloading = false;
  List<VideoInfo> downloadedVideos = [];
  var paymentCubit = getIt<PaymentCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:
      AppBarConstant(
          isLeading: true,

              () {
            back();
            Navigator.pop(context);
          }),
      body: MultiBlocListener(
        listeners: [
          BlocListener<VideoplayerCubit, VideoplayerState>(
            listener: (context, state) async {
              if (state is VideoPlayerLoaded) {
                videoModel = state.response;
                // videoModel[0].videoPlayer[0].free_movie == "0" &&
                    isSubScriber == "1" ?
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            MoviePlay(videoModel[0].videoPlayer[0].videoLink)
                        ))
                 : isSubScriber == "0" && movieModel[0].free_movie == "1" ?
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>

                            MoviePlay(videoModel[0].videoPlayer[0].videoLink)
                        ))
                  :isSubScriber == "0" && movieModel[0].free_movie == "0" ?
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Payment()
                        )) :
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Payment()
                        ));

              }
              // TODO: implement listener
            },
          ),
          BlocListener<PaymentCubit, PaymentState>(
            listener: (context, state) {
              // TODO: implement listener
            },
          ),
        ],
        child:
        BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MoviePreviewLoaded) {
              movieModel = state.response;
              return Container(
                margin: EdgeInsets.only(left: 3.w),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        CatchImage(
                            imageUrl: "${Globals.imageBaseUrl}${movieModel[0]
                                .bannerLink}",
                            height: systemHeight(18.h, context),
                            width: systemWidth(100.w, context), isFree: "0"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              movieModel[0].title,
                              style: TextStyle(
                                fontFamily: 'GeoBook',
                                fontSize: 25.sp,
                                color: ColorConstantss.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(icon: Icon(
                                Icons.play_arrow,
                                color: ColorConstantss.white,),
                                onPressed: () async {
                                  FormData jsonBody = FormData.fromMap({
                                    "video_id": movieModel[0].videoId,
                                    "user_id": userID
                                  });
                                  Map a = {
                                    "video_id": movieModel[0].videoId,
                                    "user_id": userID
                                  };
                                  print("PARSE DATA FOR SHOWING VIDEO ${a}");
                                  videoCubit.getVideo(jsonBody);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10.w),
                                  backgroundColor:
                                  movieModel[0].free_movie == "1"
                                      ? Colors.blue
                                      :
                                  isSubScriber == "0"
                                      ? Colors.blue
                                      : ColorConstantss.red
                                  ,
                                ),
                                label:
                                Text(
                                  isSubScriber == "1"
                                      ? 'Play':
                                  movieModel[0].free_movie =="1"?
                                  "Free to Watch" : 'Subscribe to Watch',
                                  style: TextStyle(
                                      color: ColorConstantss.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSizeConstants.size14),
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(
                          height: systemHeight(2, context),
                        ),

                        /// hide for production
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Icon(Icons.play_arrow_outlined,size: 35,color: ColorConstantss.red,),
                        //     Icon(Icons.add,size: 35,color: ColorConstantss.red,),
                        //     Icon(Icons.share_outlined,size: 30,color: ColorConstantss.red,)
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: systemHeight(3, context),
                        // ),

                        RatingBarIndicator(
                          rating: int.parse(movieModel[0].ratings).toDouble(),
                          itemBuilder: (context, index) =>
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        _text("Description", movieModel[0].description,
                            ColorConstantss.grey),
                        _text("Genres :", movieModel[0].genreName,
                            ColorConstantss.grey),
                        _text("Language :", "${movieModel[0].languageName}",
                            ColorConstantss.grey),



                      ],
                    ),
                  ),
                ),
              );
            }
            else {
              return Center(
                child: CupertinoActivityIndicator(
                    color: ColorConstantss.red, animating: true, radius: 15),
              );
            }
          },
        ),
      ),
    );
  }



  _text(String? s, String t, Color color) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   s??"",
          //   style: TextStyle(
          //     fontFamily: 'GeoBook',
          //     fontSize: 18,
          //     color: ColorConstantss.white,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          // SizedBox(
          //   width: systemWidth(2, context),
          // ),
          Flexible(
            child: Text(
              t,
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadAndSaveVideo(String videoUrl) async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Construct a unique filename based on the current timestamp
      String localPath2 = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Download M3U8 video
      Response response = await dio.get(videoUrl);

      List<int> bytes = response.data.codeUnits;

      // Save the video locally
      File localFile = File(localPath2);
      await localFile.writeAsBytes(bytes);

      // Store the local path in shared preferences
      VideoInfo videoInfo = VideoInfo(videoPath: localPath2
          , title: 'Video ${downloadedVideos.length}');

      // Store the VideoInfo object in shared preferences
      downloadedVideos.add(videoInfo);
      prefs.setStringList('downloaded_videos', downloadedVideos.map((v) => json.encode(v)).toList());


      // Update the UI
      setState(() {
        downloadedVideos = List.from(downloadedVideos);
        print(downloadedVideos);
      });
    } catch (error,t) {
      print('Error downloading video: $error');
      print('Error downloading video trace: $t');
    }
  }
}
class VideoInfo {
  final String videoPath;
  final String title;

  VideoInfo({required this.videoPath, required this.title});

  Map<String, dynamic> toJson() {
    return {
      'videoPath': videoPath,
      'title': title,
    };
  }
  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      videoPath: json['videoPath'],
      title: json['title'],
    );
  }
}
///
// class VideoInfo {
//   final String userId;
//   final String title;
//   final String description;
//   final String filePath;
//
//   VideoInfo({
//     required this.userId,
//     required this.title,
//     required this.description,
//     required this.filePath,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'title': title,
//       'description': description,
//       'filePath': filePath,
//     };
//   }
//
//   factory VideoInfo.fromJson(Map<String, dynamic> json) {
//     return VideoInfo(
//       userId: json['userId'],
//       title: json['title'],
//       description: json['description'],
//       filePath: json['filePath'],
//     );
//   }
// }
