import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/shows_episode_cubit/shows_episode_state.dart';
import 'package:shinestreamliveapp/data/api.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shinestreamliveapp/data/models/webseriesModel/episodesdatamodel.dart';
import 'package:shinestreamliveapp/data/models/webseriesModel/webSeresdatamodel.dart';
import 'package:shinestreamliveapp/main.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../../cubit_bloc/shows_episode_cubit/shows_episode_cubit.dart';
import '../../../di/locator.dart';
import '../../../utils/color_constants.dart';
import '../../../utils/shared_prefs.dart';
import '../../../video_library/new_movie_player.dart';
import '../../payment/payment.dart';
import '../../widget_components/app_bar_components.dart';
import '../../widget_components/catched_image.dart';

class ShowsEpisodeScreen extends StatefulWidget {
  final Map videoMapData;

  const ShowsEpisodeScreen({Key? key, required this.videoMapData}) : super(key: key);

  @override
  State<ShowsEpisodeScreen> createState() => _ShowsEpisodeScreenState();
}

class _ShowsEpisodeScreenState extends BaseScreen<ShowsEpisodeScreen> {
  String? subScription;
  var episodeCubit = getIt<ShowsEpisodeCubit>();
  WebSeriesDataModel webSeriesDataModel = WebSeriesDataModel.fromJson({});
  List<EpisodesDataModel> episodesDataModel = <EpisodesDataModel>[];
  int selectedIndex = 0;

  @override
  void initState() {
    subScription = prefs.getString(SharedConstants.subScription);
    Logger().d("SHOWS EPISODE GET VIDEO ID ${widget.videoMapData}");

    // Fetch web series data
    FormData jsonData = FormData.fromMap({
      'web_id': widget.videoMapData["web_id"],
    });
    episodeCubit.getShowsSeriesData(jsonData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstant(
        isLeading: true,
            () {
          Navigator.pop(context);
        },
      ),
      body: BlocListener<ShowsEpisodeCubit, ShowsEpisodeState>(
        listener: (context, state) {
          if (state is ShowsDataLoaded) {
            webSeriesDataModel = state.response;
            var seasonId = webSeriesDataModel.seasons!.first.seasonId;
            FormData jsonData = FormData.fromMap({
              'web_id': widget.videoMapData['web_id'],
              'season_id': seasonId,
            });
            episodeCubit.getShowsEpisodesData(jsonData);
          }
          else if (state is ShowsEpisodesLoaded) {
            episodesDataModel = state.response;
          }
        },
        child: BlocBuilder<ShowsEpisodeCubit, ShowsEpisodeState>(
          builder: (context, state) {
            if (state is ShowsDataLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: ColorConstantss.red,
                  radius: 13.r,
                ),
              );
            } else if (state is ShowsDataLoaded) {
              webSeriesDataModel = state.response;
              Logger().d("AFTER VIDEO PLAYER LOAD ${webSeriesDataModel.title}");
              return buildSeriesData();
            } else if (state is ShowsEpisodesLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: ColorConstantss.red,
                  radius: 13.r,
                ),
              );
            }
            else if (state is ShowsEpisodesLoaded) {
              episodesDataModel = state.response;
              return buildSeriesData();
            }
            else {
              return Center(child: CupertinoActivityIndicator(color: ColorConstantss.red,radius: 13.r,));
            }
          },
        ),
      ),
    );
  }

  Widget buildSeriesData() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CatchImage(
                imageUrl: "${Globals.imageBaseUrl}${webSeriesDataModel.banner}",
                height: systemHeight(18.h, context),
                width: systemWidth(100.w, context), isFree: "0"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  webSeriesDataModel.title ?? "NA",
                  style: TextStyle(
                    fontFamily: 'GeoBook',
                    fontSize: 17.sp,
                    color: ColorConstantss.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBarIndicator(
                  rating: int.parse(webSeriesDataModel.rating.toString())
                      .toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                _text(
                    "Genres :",
                    "${webSeriesDataModel.categoryName ?? ""} | ${webSeriesDataModel.year ?? ""}",
                    ColorConstantss.grey),
                _text("Language :", webSeriesDataModel.languageName ?? "",
                    ColorConstantss.grey),
                _text("Cast :", webSeriesDataModel.cast?.replaceAll(',', ' | ') ?? "",
                    ColorConstantss.grey),
                Text(
                  "About",
                  style: TextStyle(
                      color: ColorConstantss.white.withOpacity(0.8),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
                ReadMoreText(
                  style: TextStyle(color: ColorConstantss.grey,fontSize: 10.sp),
                  "${webSeriesDataModel.description}",
                  numLines: 2,
                  readMoreText: 'Read more',
                  readMoreIcon: const Icon(
                    Icons.expand_more,
                    color: Colors.transparent,
                    size: 1,
                  ),
                  readLessText: 'Read less',
                  readLessIcon: const Icon(
                    Icons.expand_more,
                    color: Colors.transparent,
                    size: 1,
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  webSeriesDataModel.seasons!.length,
                      (index) => InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      var seasonId = webSeriesDataModel.seasons![index].seasonId;
                      FormData jsonData = FormData.fromMap({
                        'web_id': widget.videoMapData['web_id'],
                        'season_id': seasonId,
                      });
                      episodeCubit.getShowsEpisodesData(jsonData);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.r),
                          color: index == selectedIndex
                              ? ColorConstantss.red // Color for selected index
                              : Colors.transparent,
                          border: Border.all(color: Colors.grey)),
                      padding: EdgeInsets.all(5.w),
                      margin: EdgeInsets.only(top:10.w,bottom: 10.w,right: 10.w),
                      child: Text(
                        "Season ${index + 1}",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<ShowsEpisodeCubit, ShowsEpisodeState>(builder: (context, state) {
              if(state is ShowsEpisodesLoading){
                return CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,);
              }
              if(state is ShowsEpisodesLoaded){
                episodesDataModel =state.response;
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            InkWell(
                              onTap:(){
                                AppLog.i(subScription);
                                subScription == '1'?

                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    MoviePlay(episodesDataModel[index].fileName),)) :
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                const Payment(),));
                              },
                              child: SizedBox(
                                  width: systemWidth(25.h, context),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child:
                                    CatchImageByPath(
                                      imageUrl: "${Globals.imageBaseUrl}${episodesDataModel[index].thumbnail}",),
                                  )),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${episodesDataModel[index].title}',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: ColorConstantss.white),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${episodesDataModel[index].descriptions}',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.grey),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${episodesDataModel[index].duration}',
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.grey),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: episodesDataModel.length,
                  shrinkWrap: true,
                );

              }
              else{
                return CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,);
              }
            },),

          ],
        ),
      ),
    );
  }

  _text(String? s, String t, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              t,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: 10.sp,
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
