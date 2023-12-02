import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/data/api.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../cubit_bloc/movie_cubit/movie_cubit.dart';
import '../../cubit_bloc/payment/payment_cubit.dart';
import '../../cubit_bloc/vidoeplayer_cubit/videoplayer_cubit.dart';
import '../../data/models/moviepreviewmodel.dart';
import '../../data/models/videoplayermodel.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../payment/payment.dart';
import '../widget_components/app_bar_components.dart';
import 'movieplay.dart';
class SeriesEpisodeScreen extends StatefulWidget {
final Map videoMapData;
   SeriesEpisodeScreen({super.key, required this.videoMapData,});

  @override
  State<SeriesEpisodeScreen> createState() => _SeriesEpisodeScreenState();
}

class _SeriesEpisodeScreenState extends BaseScreen<SeriesEpisodeScreen> {
  late List<VideoPlayerModel> videoModel = [];
  late List<MoviePreviewModel> movieModel = [];

  var movieCubit = getIt<MovieCubit>();


  var videoCubit = getIt<VideoplayerCubit>();
  @override
  void initState() {
Logger().d("SERIES EPISOD GET VIDEOID ${widget.videoMapData}");
Logger().f("RECIVED VIDEO ID::${widget.videoMapData["video_id"]}");
    super.initState();
  }
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  int selectedIndex = 0;
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarConstant(
        isLeading: true,

        InkWell(
          onTap: () {},
          child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 10),
              child: Icon(
                Icons.language_outlined,
                color: ColorConstantss.red,
              )),
        ), (){Navigator.pop(context);}),
    body:
    MultiBlocListener(listeners: [
      BlocListener<VideoplayerCubit, VideoplayerState>(
        listener: (context, state) async {
          if(state is VideoPlayerLoaded){
            videoModel = state.response;
            Logger().d("AFTER VIDEO PLYER LOAD${videoModel.toString()}");
            videoModel[0].status == false ?
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Payment()
                  //builder: (context) => MoviePlay(videoModel[0].videoPlayer[0].videoLink)
                )):Navigator.push(
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

    ], child:
    SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Image.network("${Globals.imageBaseUrl}${widget.videoMapData["thumbnail"]}",
                height: systemHeight(30, context),width: double.infinity,fit: BoxFit.fill),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                widget.videoMapData["title"],
                style: TextStyle(
                  fontFamily: 'GeoBook',
                  fontSize: 20,
                  color: ColorConstantss.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(icon: Icon(Icons.play_arrow,color: ColorConstantss.black,),
                  onPressed: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? userID =prefs.getString("${SharedConstants.udid}");
                    FormData jsonBody =  FormData.fromMap({ "video_id": widget.videoMapData["video_id"],"user_id":userID});
                    Map a ={ "video_id": widget.videoMapData["video_id"],"user_id":userID} ;
                    Logger().d("PARSE DATA FOR SHOWING VIDEO ${a}");
                    videoCubit.getVideo(jsonBody);

                  },
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                    backgroundColor: ColorConstantss.white,

                  ),
                  label:

                  Text(
                    "Subscribe to Watch",
                    style: TextStyle(
                        color: ColorConstantss.black,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSizeConstants.size14),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("About",style: TextStyle(color: ColorConstantss.white.withOpacity(0.8),fontSize: 15,fontWeight: FontWeight.w500),),
          //
          //       ReadMoreText(
          //         style:TextStyle(color: ColorConstantss.grey),
          //         "Removing the --split-per-abi flag results in a fat APK that contains your code compiled for all the target ABIs. Such APKs are larger in size than their split counterparts, causing the user to downloa"
          //             "d native binaries that are not applicable to their device’s architecture",
          //         numLines: 2,
          //         readMoreText: 'Read more',readMoreIcon: Icon(Icons.expand_more,color: Colors.transparent,size: 1,),
          //         readLessText: 'Read less',readLessIcon: Icon(Icons.expand_more,color: Colors.transparent,size: 1,),
          //       )
          //     ],
          //   ),
          //
          // ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(children: List.generate(10, (index) =>
          //       InkWell
          //         (
          //         highlightColor: Colors.transparent,
          //         splashColor: Colors.transparent,
          //         onTap: (){
          //         setState(() {
          //           // Change the color of the container at index 2
          //           // if (index == 2) {
          //             selectedIndex = index;
          //           // }
          //         });
          //       },
          //         child: Container(
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20),
          //               color:index == selectedIndex
          //           ? ColorConstantss.red // Color for selected index
          //               :Colors.transparent,
          //               border: Border.all(color: Colors.grey)),
          //           // color: Colors.transparent,
          //           child: Text("Season ${index+1}",style: TextStyle(color:index == selectedIndex? ColorConstantss.white: ColorConstantss.grey),),
          //           padding: EdgeInsets.all(5),
          //           margin: EdgeInsets.all(10),
          //         ),
          //       ),),),),
          //   ListView.separated(
          // separatorBuilder: (context, index) {
          //     return SizedBox(height: 10,);
          //   }, physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //     return Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Stack(
          //           children: [
          //             SizedBox(width: systemWidth(25, context),
          //                 child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(8),
          //                     child: Image.network(imgList[index], fit: BoxFit.fill,))),
          //             // Icon(Icons.play_circle,color: ColorConstantss.red,),
          //
          //           ],alignment: Alignment.center,
          //         ),
          //         Expanded(
          //           child: Padding(
          //             padding:  EdgeInsets.symmetric(horizontal: 10),
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   'It is a long established  its layout.',
          //                   style: TextStyle(fontSize: 13,color: ColorConstantss.white),
          //                   softWrap: true,
          //                   maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //
          //                 ReadMoreText(
          //                   style:TextStyle(color: ColorConstantss.grey),
          //                   "Removing the architecture",
          //                   numLines: 2,
          //                   readMoreText: 'Read more',readMoreIcon: Icon(Icons.expand_more,color: Colors.transparent,size: 1,),
          //                   readLessText: 'Read less',readLessIcon: Icon(Icons.expand_more,color: Colors.transparent,size: 1,),
          //                 )
          //                 // Text(
          //                 //   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
          //                 //   style: TextStyle(fontSize: 11,color: ColorConstantss.grey),
          //                 //   softWrap: true,
          //                 //   maxLines: 2,
          //                 // ),
          //
          //               ],
          //             ),
          //           ),
          //         )
          //       ],);
          //   },itemCount: imgList.length,shrinkWrap: true,)

        ],),
    ),

    ),

    );

  }
}
