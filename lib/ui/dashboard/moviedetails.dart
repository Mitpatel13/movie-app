import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/cubit_bloc/home_cubit/home_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/payment/payment_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/vidoeplayer_cubit/videoplayer_cubit.dart';
import 'package:shinestreamliveapp/data/api.dart';
import 'package:shinestreamliveapp/data/models/moviepreviewmodel.dart';
import 'package:shinestreamliveapp/ui/widget_components/catched_image.dart';
import 'package:shinestreamliveapp/utils/globle_var.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:shinestreamliveapp/ui/payment/payment.dart';

import '../../basescreen/base_screen.dart';
import '../../cubit_bloc/download_data/download_bloc.dart';
import '../../cubit_bloc/download_data/download_event_state.dart';
import '../../data/models/videoplayermodel.dart';
import '../../data/repository/videoplayerrepository.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/app_bar_components.dart';
import 'movieplay.dart';
import 'package:path_provider/path_provider.dart';

class MovieDetails extends StatefulWidget {
  String videoId;
  // String? cateGory;
  MovieDetails(this.videoId, {Key? key}) : super(key: key);
  // String a =ca

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends BaseScreen<MovieDetails> {
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
  @override
  void initState() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID =prefs.getString("${SharedConstants.udid}");
    Logger().f("RECIVED VIDEO ID::${widget.videoId}");
    FormData jsonBody = FormData.fromMap({"video_id": widget.videoId});
  movieCubit.moviePreview(jsonBody);
    // FormData jsonBody2 =  FormData.fromMap({ "video_id": widget.videoId,"user_id":userID});
    // Map a ={ "video_id": widget.videoId,"user_id":userID} ;
    // print("PARSE DATA FOR SHOWING VIDEO ${a}");
    // videoPlayer.getVideo(jsonBody2);
    // callInit();
    // TODO: implement initState
    super.initState();
  }
  callInit()async{
    print("=================FLUTTER DOWNLOER INIT CALL ========");
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  }
  back()async{
   await  movieCubit.allMovie();
  }
  final List<String> videoUrls = [
    'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    "https://file-examples.com/wp-content/storage/2017/04/file_example_MP4_480_1_5MG.mp4"
    // Add more video URLs as needed
  ];



  Future<void> downloadVideo(String videoUrl) async {
    try{
      final response = await http.get(Uri.parse(videoUrl));
      if(response.statusCode == 200){
        Logger().d("SUCESS RESPONCE");
      }
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final file = File('${appDocumentsDirectory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4');

      await file.writeAsBytes(response.bodyBytes);

      setState((){
        Logger().d(file.path);
        downloadedVideos.add(file);
        Logger().f(downloadedVideos.toList());
      });
    }catch(e,t){
      Logger().d(e);
      Logger().d(t);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:
      AppBarConstant(
          isLeading: true,

          SizedBox(),(){
            back();
            Navigator.pop(context);}),
      body:MultiBlocListener(
    listeners: [
      // BlocListener<HomeCubit,HomeState>(listener: (context, state) async{
      //   if(state is  Ac)
      // },),
        BlocListener<VideoplayerCubit, VideoplayerState>(
    listener: (context, state) async {
        if(state is VideoPlayerLoaded){
    videoModel = state.response;
    videoModel[0].status == false ?
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Payment()
                //builder: (context) => MoviePlay(videoModel[0].videoPlayer[0].videoLink)
            )):
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => MoviePlay(videoModel[0].videoPlayer[0].videoLink)
        ));


      // ScaffoldMessenger.of(context).showSnackBar(Sna)
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? subScription =prefs.getString("${SharedConstants.subScription}");
    Logger().d(subScription);
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
        if(state is MoviePreviewLoaded)
    {
      movieModel = state.response;
      return Container(
        margin: EdgeInsets.only(left:3),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      CatchImage(
                          imageUrl:"${Globals.imageBaseUrl}${movieModel[0].bannerLink}" ,
                          height: systemHeight(30, context),
                          width: systemWidth(100, context), isFree: false),
                      // Image.network("https://www.shinestreamlive.com/"+movieModel[0].bannerLink,
                      // height: systemHeight(30, context),width: systemWidth(100, context),),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Column(
                          //   children: [
                          //     ElevatedButton(onPressed: (){downloadVideo(videoUrls[0]);
                          //
                          //     }, child: Text("DOWNLOAD VIDEO")),
                          //     ElevatedButton(onPressed: (){
                          //       downloadVideo(videoUrls[1]);
                          //
                          //     }, child: Text("DOWNLOAD VIDEO 2")),
                          //   ],
                          // ),

                          Text(
                            movieModel[0].title,
                            style: TextStyle(
                              fontFamily: 'GeoBook',
                              fontSize: 20,
                              color: ColorConstantss.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                         //  InkWell(
                         //   onTap:() async {
                         //     SharedPreferences prefs = await SharedPreferences.getInstance();
                         //     String? userID =prefs.getString("${SharedConstants.udid}");
                         //     FormData jsonBody =  FormData.fromMap({ "video_id": widget.videoId,"user_id":userID});
                         //     Map a ={ "video_id": widget.videoId,"user_id":userID} ;
                         //     print("PARSE DATA FOR SHOWING VIDEO ${a}");
                         //     videoCubit.getVideo(jsonBody);
                         //
                         //   },
                         //   child: Icon(Icons.play_circle_fill_outlined,size: 50,color:ColorConstantss.red),
                         //
                         // )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(icon: Icon(Icons.play_arrow,color: ColorConstantss.white,),
                              onPressed: ()async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String? userID =prefs.getString("${SharedConstants.udid}");
                                FormData jsonBody =  FormData.fromMap({ "video_id": movieModel[0].videoId,"user_id":userID});
                                Map a ={ "video_id": movieModel[0].videoId,"user_id":userID} ;
                                print("PARSE DATA FOR SHOWING VIDEO ${a}");
                                videoCubit.getVideo(jsonBody);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Colors.blue
                                ,

                              ),
                              label:

                                // : GradientText(
                                //   'Hello Flutter',
                                //   style: const TextStyle(fontSize: 40),
                                //   gradientType: GradientType.linear,
                                //     colors: [
                                //       Colors.blue.shade400,
                                //       Colors.blue.shade900,
                                //     ]
                                // ),

                              // movieModel[0].isFree ==0 ?
                              // Text("Watch Free",style: TextStyle(
                              //     color: ColorConstantss.black,
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: FontSizeConstants.size14),)
                              //     :
                              Text(
                                "Subscribe to Watch",
                                style: TextStyle(
                                    color: ColorConstantss.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeConstants.size14),
                              ),
                            ),
                          ),
                          // videoModel[0].videoPlayer[0].videoLink.isNotEmpty?
                          //     Padding(
                          //       padding: const EdgeInsets.only(left: 8.0),
                          //       child: InkWell(
                          //           onTap: () async {
                          //                 String? userID =prefs.getString("${SharedConstants.udid}");
                          //                 FormData jsonBody =  FormData.fromMap({ "video_id": movieModel[0].videoId,"user_id":userID});
                          //                 Map a ={ "video_id": widget.videoId,"user_id":userID} ;
                          //                 Logger().e("PARSE DATA FOR SHOWING VIDEO ${a}");
                          //                 List<VideoPlayerModel> data =await  videoPlayer.getVideo(jsonBody);
                          //                 Logger().d("LIST IF VIDEO DATA IS :::: ${data[0].videoPlayer[0].toJson()}");
                          //
                          //                 context.read<DownloadCubit>().startDownload(
                          //                   movieModel[0].videoId,
                          //                   movieModel[0].title,
                          //                   "${Globals.imageBaseUrl}${data[0].videoPlayer[0].videoLink}" ,
                          //                   "${Globals.imageBaseUrl}${movieModel[0].bannerLink}",
                          //                 );
                          //                     // VideoPlayer1(
                          //                     //   videoId: movieModel[0].videoId,
                          //                     //   videoLink:data[0].videoPlayer[0].videoLink ,
                          //                     //   title: movieModel[0].title,)
                          //                 // );
                          //
                          //                 requestDownload("${Globals.imageBaseUrl}"
                          //                     "${data[0].videoPlayer[0].videoLink}",
                          //                     movieModel[0].title);
                          //
                          //           },
                          //           child: Icon(Icons.download,size: 30,color: ColorConstantss.red,)),
                          //     )
                                  // :SizedBox()


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
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      _text("Description",movieModel[0].description,ColorConstantss.grey),
                      _text("Genres :",movieModel[0].genreName,ColorConstantss.grey),
                      _text("Language :","${movieModel[0].languageName}",ColorConstantss.grey),
                      // _text("Rating :",movieModel[0].ratings),
                      // _text("Language :", movieModel[0].languageName),
                      // _text("The Cast :"," "),
                      // SizedBox(
                      //   height: systemHeight(2, context),
                      // ),
                      // Padding(padding: EdgeInsets.only(left:10,right:10),
                      //   child: Text(
                      //     "More Details",
                      //     style: TextStyle(
                      //       fontFamily: 'GeoBook',
                      //       fontSize: 18,
                      //       color: ColorConstantss.white,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),),
                      // Divider(
                      //
                      //   thickness: 1,
                      //   color: ColorConstantss.white,
                      // ),
                      // _text("Genres :",movieModel[0].genreName),
                      // _text("Language :",movieModel[0].languageName),
                      // _text("Rating :",movieModel[0].ratings),
                      // _text("Director : ",""),
                      // _text("Starring : "," "),
                      // _text("Studios : "," "),
                      // SizedBox(
                      //   height: systemHeight(2, context),
                      // ),

                      // Text(
                      //   "Related Movies",
                      //   style: TextStyle(
                      //     fontFamily: 'GeoBook',
                      //     fontSize: 18,
                      //     color: ColorConstantss.white,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
        else {
    return Center(
      child: CupertinoActivityIndicator(color: ColorConstantss.red,animating: true,radius: 15),
    );
        }

    },
        ),
        ),
      );
  }
  Future<void> requestDownload(String _url, String _name) async {
    Logger().d("REQUESTED URL IS :::${_url}");
    Logger().d("REQUSTED NAME IS ::::${_name}");
    final dir =
    await getApplicationDocumentsDirectory(); //From path_provider package
    var _localPath = dir.path + _name;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      print("object");
      var taskid =
      await FlutterDownloader.enqueue(
        url: _url,
        fileName: _name,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: false,
      );
      print("TASK ID AFTER DOWNLOAD=====>$taskid");
    });
  }

  _text(String? s, String t,Color color) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10),
    child:  Row(
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
}
