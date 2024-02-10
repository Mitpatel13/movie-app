import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/home_cubit/home_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/series_cubit/series_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/shows/shows_state.dart';
import 'package:shinestreamliveapp/cubit_bloc/shows/shws_cubit.dart';
import 'package:shinestreamliveapp/data/models/homebannermodel.dart';
import 'package:shinestreamliveapp/data/models/seriesmodel.dart';
import 'package:shinestreamliveapp/ui/dashboard/moviedetails.dart';
import 'package:shinestreamliveapp/ui/dashboard/series_episode_screen.dart';
import 'package:shinestreamliveapp/ui/dashboard/view_all_movie.dart';
import 'package:shinestreamliveapp/ui/widget_components/catched_image.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';
import '../../data/api.dart';
import '../../data/models/seriesbannermodel.dart';
import '../../di/locator.dart';
import '../../utils/check_internet.dart';
import '../../utils/color_constants.dart';
import '../../utils/home_carousel_slider.dart';
import '../dashboard/languageselection.dart';
import '../dashboard/shows/shows_episodes_screem.dart';
import '../widget_components/app_bar_components.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen>
    with TickerProviderStateMixin {
  // InternetConnectionStatus? _connectionStatus;
  // late StreamSubscription<InternetConnectionStatus> _subscription;
  late TabController _controller;
  final List<String> imgList = [
    "assets/advertiseBanner/mobile ads.png",
    "assets/advertiseBanner/mobile ads.png"];
  final List<String> imgListByDefaultAd = [
    AppAsset.adsThumb1,
    AppAsset.adsThumb2,
    AppAsset.adsThumb3,
  ];
  final Map<String, dynamic> dynamicAdList = {
    "Action Movies": [AppAsset.adsThumb1, AppAsset.adsThumb2],
    "Classic Movies": [AppAsset.adsThumb3],
  };
  late List<HomeBannerModel> hbModel = [];
  late List<SeriesModel> seriesModel = [];
  late List<SeriesBannerModel> sbModel = [];
  late List<ActionMovieModel> actionModel = [];
  late List<ActionMovieModel> classicMovie = [];
  late List<ActionMovieModel> comedyMovie = [];
  late List<ActionMovieModel> crimeMovie = [];
  late List<ActionMovieModel> romanticMovie = [];
  late List<ActionMovieModel> telugufavMovie = [];
  late List<ActionMovieModel> dramaMovie = [];
  late List<ActionMovieModel> kidsMovie = [];
  late List<ActionMovieModel> sportsMovie = [];
  late List<ActionMovieModel> devotionalMovie = [];
  late List<ActionMovieModel> folkSongs = [];
  late List<ActionMovieModel> oldIsGold = [];
  late List<ActionMovieModel> bestHollywood = [];
  late List<ActionMovieModel> bestSouth = [];
  var homeCubit = getIt<HomeCubit>();
  var seriesCubit = getIt<SeriesCubit>();
  var showsCubit = getIt<ShowsCubit>();
  bool isLoad = false;
  bool isNoInternet = false;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position _currentPosition;
  late Position position;
  late String _currentAddress;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  int indexForTab =0;

  @override
  void initState() {

    checkGps();
    onCheckInternet(context).then((value) {
      Logger().e(value);
      homeCubit.homeBanner();
    });
    setState(() {
      isLoad = true;
    });
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
        AppLog.i("GET CURRENT ADDRESS IS $_currentAddress");
      });
    } catch (e) {
      print(e);
    }
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();

      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }


  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    AppLog.i(position.longitude);
    AppLog.i(position.latitude);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude
    );

    Placemark place = placemarks[0];

    setState(() {
      _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea  }";
      AppLog.i("GET CURRENT ADDRESS IS $_currentAddress");
    });

  }

  @override
  Widget build(BuildContext context) {
    dynamic listeners = [

      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HBLoading) {
          } else if (state is HBLoaded) {
            homeCubit.actionMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
            hbModel = state.response;
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is ActionLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is ActionLoaded) {
            homeCubit.classicMovie();
            actionModel = state.response;
            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is ClassicLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is ClassicLoaded) {
            classicMovie = state.response;
            homeCubit.comedyMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is ComedyLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is ComedyLoaded) {
            comedyMovie = state.response;
            homeCubit.crimeMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is CrimeLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is CrimeLoaded) {
            crimeMovie = state.response;
            homeCubit.romanticMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is RomanticLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is RomanticLoaded) {
            romanticMovie = state.response;
            homeCubit.telugufavMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is TeluguFavLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is TeluguFavLoaded) {
            telugufavMovie = state.response;
            homeCubit.dramaMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DramaLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is DramaLoaded) {
            dramaMovie = state.response;
            homeCubit.kidsMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is KidsLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is KidsLoaded) {
            kidsMovie = state.response;
            homeCubit.sportsMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SportsLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is SportsLoaded) {
            sportsMovie = state.response;
            homeCubit.devotionalMovie();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DevotionalLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is DevotionalLoaded) {
            devotionalMovie = state.response;
            homeCubit.folkSongs();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is FolkLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is FolkLoaded) {
            folkSongs = state.response;
            homeCubit.oldIsGold();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is OldIsGoldLoading) {
            //LoaderWidget.showProgressIndicatorAlertDialog(context);
          } else if (state is OldIsGoldLoaded) {
            oldIsGold = state.response;
            homeCubit.bestHollywood();

            //LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is BestHollyLoading) {
          } else if (state is BestHollyLoaded) {
            bestHollywood = state.response;
            homeCubit.bestSouth();

          }
        },
      ),
      BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is BestSouthLoading) {
            isLoad = false;
            setState(() {});
          } else if (state is BestSouthLoaded) {
            bestSouth = state.response;

          }
        },
      ),

    ];


    Future<void> _onRefresh() async {
      homeCubit.homeBanner();
      setState(() {
        isLoad = true;
      });
      Logger().f('refreshing stocks...');
    }

    return Scaffold(
        
        appBar: AppBarConstant(
            isLeading: false,
                () {
        }),
      
        body:


            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      indexForTab == 0 ?
                    BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (context, state) {
                    return state is HBLoaded;
                  },
                  builder: (context, state) {
                    if (state is HBLoaded) {
                      return
                        homeCarouselSlider(context: context,dataModel:hbModel,imgList: imgList );
                    } else if (state is HBLoading) {

                      return SizedBox(
                          height: MediaQuery.sizeOf(context).height /1.5,
                          child: Center(child: CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,)));
                    } else {
                      return SizedBox(
                          height: MediaQuery.sizeOf(context).height /1.5,

                          child: Center(child: CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,)));
                    }
                  },
                  )
                          :
                      indexForTab == 1 ?
                      BlocBuilder<SeriesCubit, SeriesState>(
                        buildWhen: (context, state) {
                          return state is SBLoaded;
                        },
                        builder: (context, state) {
                          if (state is SBLoaded) {
                            seriesCubit.seriesList();
                            sbModel =state.response;
                            return
                                homeCarouselSlider(context: context, dataModel: sbModel, imgList: imgList);
                              // CarouselSlider(
                              //   options: CarouselOptions(
                              //     autoPlayAnimationDuration:
                              //     const Duration(seconds: 1),
                              //     autoPlayCurve: Curves.linear,
                              //
                              //     viewportFraction: 1,height: MediaQuery.sizeOf(context).height/1.5,
                              //     autoPlay: true,
                              //     reverse: false,
                              //     autoPlayInterval:
                              //     const Duration(seconds: 3),
                              //     pauseAutoPlayOnTouch: true,
                              //   ),
                              //   items: List.generate(
                              //     sbModel.length + (sbModel.length ~/ 2),
                              //         (index) {
                              //       if (index % 3 == 2) {
                              //         int imgIndex = index ~/ 3;
                              //         imgIndex %= imgList.length; // Wrap around imgList2 indices
                              //
                              //         return InkWell(
                              //           onTap: () {
                              //             Logger().d("ON TAP IMAGEINDEX IS ${imgIndex}");
                              //           },
                              //           child: SizedBox(
                              //             width: double.infinity,
                              //             child: Image(
                              //               image: AssetImage(
                              //                 // AppAsset.trialPoster
                              //                 imgList[imgIndex],
                              //               ),
                              //               fit: BoxFit.fill,
                              //
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //       else{
                              //         int modelIndex = index - (index ~/ 3);
                              //         return
                              //           InkWell(
                              //             onTap: (){
                              //               print(sbModel[modelIndex].toJson());
                              //             },
                              //             child:
                              //             SizedBox(
                              //               width: double.infinity,
                              //               child:CachedNetworkImage(imageUrl: "${Globals.imageBaseUrl}${sbModel[modelIndex].thumbnail}",fit: BoxFit.fill,)
                              //             ),
                              //           );
                              //       }
                              //
                              //     },
                              //   ),
                              // );
                          } else if (state is SBLoading) {

                            return SizedBox(
                                height: MediaQuery.sizeOf(context).height/1.5,
                                child: Center(child: CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,)));
                          } else {
                            return SizedBox(
                                height: MediaQuery.sizeOf(context).height/1.5,

                                child: Center(child: CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,)));
                          }
                        },
                      ) :
                      BlocBuilder<ShowsCubit, ShowsState>(
                        buildWhen: (context, state) {
                          return state is ShowsBannerLoaded;
                        },
                        builder: (context, state) {
                          if (state is ShowsBannerLoaded) {
                            showsCubit.showsList();
                            sbModel =state.response;
                            return
                                homeCarouselSlider(context: context, dataModel: sbModel, imgList: imgList);
                              // CarouselSlider(
                              //   options: CarouselOptions(
                              //     autoPlayAnimationDuration:
                              //     const Duration(seconds: 1),
                              //     autoPlayCurve: Curves.linear,
                              //
                              //     viewportFraction: 1,height: MediaQuery.sizeOf(context).height/1.5,
                              //     autoPlay: true,
                              //     reverse: false,
                              //     autoPlayInterval:
                              //     const Duration(seconds: 3),
                              //     pauseAutoPlayOnTouch: true,
                              //   ),
                              //   items: List.generate(
                              //     sbModel.length + (sbModel.length ~/ 2),
                              //         (index) {
                              //       if (index % 3 == 2) {
                              //         int imgIndex = index ~/ 3;
                              //         imgIndex %= imgList.length; // Wrap around imgList2 indices
                              //
                              //         return InkWell(
                              //           onTap: () {
                              //             Logger().d("ON TAP IMAGEINDEX IS ${imgIndex}");
                              //           },
                              //           child: Container(
                              //             width: double.infinity,
                              //             child: Image(
                              //               image: AssetImage(
                              //                 imgList[imgIndex],
                              //               ),
                              //               fit: BoxFit.fill,
                              //
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //       else{
                              //         int modelIndex = index - (index ~/ 3);
                              //         return
                              //           InkWell(
                              //             onTap: (){
                              //               print(sbModel[modelIndex].toJson());
                              //             },
                              //             child:
                              //             SizedBox(
                              //                 width: double.infinity,
                              //                 child:CachedNetworkImage(imageUrl: "${Globals.imageBaseUrl}${sbModel[modelIndex].thumbnail}",fit: BoxFit.fill,)
                              //             ),
                              //           );
                              //       }
                              //
                              //     },
                              //   ),
                              // );
                          } else if (state is ShowsBannerLoading) {

                            return SizedBox(
                                height: MediaQuery.sizeOf(context).height/1.5,
                                child: Center(child: CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,)));
                          } else {
                            return SizedBox(
                                height: MediaQuery.sizeOf(context).height/1.5,

                                child: Center(child: CupertinoActivityIndicator(radius: 13.r,color: ColorConstantss.red,)));
                          }
                        },
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            tabForHomeScreen(
                              tabText: 'Movie',
                              onTap: () {
                                setState(() {
                                  homeCubit.homeBanner();
                                  indexForTab =0;
                                });
                              },indexTab:0,),
                            SizedBox(width: 15.w,),
                            tabForHomeScreen(
                              tabText: "Web Series",
                              onTap: () {
                                setState(() {
                                  seriesCubit.seriesList();
                                  seriesCubit.seriesBanner();

                                  indexForTab =1;
                                });
                              },indexTab:1,),
                            SizedBox(width: 15.w,),

                            tabForHomeScreen(
                              tabText: 'Shows',
                              onTap: () {
                                setState(() {
                                  showsCubit.showsList();
                                  showsCubit.showsBanner();
                                  indexForTab =2;
                                });
                              },indexTab:2,),


                          ],
                        ),
                      ),


                      indexForTab == 0 ?
                      MultiBlocListener(listeners: listeners, child:
                      BlocBuilder<HomeCubit,HomeState>(builder: (context, state) {
                        if(state is BestSouthLoading){
                          return CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);
                        }
                        if(state is BestSouthLoaded){
                          return  Column(
                            mainAxisSize: MainAxisSize.min,
                         children: [
                           _text1("Action Movies"),
                           listBuild(
                             "Action Movies",
                             actionModel,
                           ),
                           _text1("Classic Movies"),
                           listBuild("Classic Movies", classicMovie),
                           _text1("Comedy Movies"),
                           listBuild("Comedy Movies", comedyMovie),
                           _text1("Crime Movies"),
                           listBuild(
                             "Crime Movies",
                             crimeMovie,
                           ),
                           _text1("Romantic Movies"),
                           listBuild(
                             "Romantic Movies",
                             romanticMovie,
                           ),
                           _text1("Telugu Fav Movies"),
                           listBuild(
                             "Telugu Fav Movies",
                             telugufavMovie,
                           ),
                           _text1("Drama Movies"),
                           listBuild(
                             "Drama Movies",
                             dramaMovie,
                           ),
                           _text1("Kids Movies"),
                           listBuild(
                             "Kids Movies",
                             kidsMovie,
                           ),
                           _text1("Sports Movies"),
                           listBuild(
                             "Sports Movies",
                             sportsMovie,
                           ),
                           _text1("Devotional Movies"),
                           listBuild(
                             "Devotional Movies",
                             devotionalMovie,
                           ),
                           _text1("Folk Songs"),
                           listBuild(
                             "Folk Songs",
                             folkSongs,
                           ),
                           _text1("Old Is Gold"),
                           listBuild(
                             "Old Is Gold",
                             oldIsGold,
                           ),
                           _text1("Best Hollywood"),
                           listBuild(
                               "Best Hollywood", bestHollywood),
                           _text1("Best South"),
                           listBuild("Best South", bestSouth),
                         ],

                          );

                        }else{
                          return CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);;
                        }
                      },))
                          :
                      indexForTab == 1?
                          BlocListener<SeriesCubit,SeriesState>(listener: (context, state) {
                            if(state is SeriesLoading){}
                            if(state is SeriesLoaded){
                              seriesModel = state.response;
                            }


                          },
                            child:BlocBuilder<SeriesCubit,SeriesState>(builder: (context, state) {
                            if(state is SeriesLoading){
                              // seriesCubit.seriesList();
                              return CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);
                            }
                            if(state is SeriesLoaded){
                              seriesModel = state.response;
                              AppLog.f(seriesModel[0].categoryName);
                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: seriesModel.length,
                                      itemBuilder: (context, index) {
                                      final SeriesModel series = seriesModel[index];

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 8.w),
                                              child: Text(series.categoryName,style: TextStyle(
                                                fontFamily: 'GeoBook',
                                                fontSize: 12.sp,
                                                color: ColorConstantss.white,
                                                fontWeight: FontWeight.w500,
                                              ),),
                                            )),
                                      SingleChildScrollView(scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: series.data.map((e) {
                                            int index = series.data.indexOf(e);
                                            return
                                            Container(
                                              width: 120.w,
                                              padding: EdgeInsets.only(left: index == 0 ? 8.w : 0,
                                                  right: 6.w,
                                                  top: 3.w
                                              ),
                                              child:
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesEpisodeScreen(videoMapData: series.data[index].toJson(),)));
                                                    },
                                                    child:
                                                    CatchImage(
                                                      imageUrl: "${Globals.imageBaseUrl}" + e.thumbnail,
                                                      height:125.h,
                                                      // systemHeight(12.h, context),
                                                      width: 120.w,
                                                      isFree:"0",
                                                    )
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  SizedBox(
                                                    // width: 120.w,
                                                    child: Text(
                                                      // "bjhbjhfjvjvuhvjhhuhuvhfvhgfhgf",
                                                      e.title,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'GeoBook',
                                                        fontSize: 11.sp,
                                                        color: ColorConstantss.white,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),)

                                      ],
                                      );}
                                                            ),
                                ],
                              );

                            }else{
                              return  CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);
                              // CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);;
                            }
                          },) ,)
                          :
                      BlocListener<ShowsCubit,ShowsState>(listener: (context, state) {
                        if(state is ShowsListLoading){}
                        if(state is ShowsListLoaded){
                          seriesModel = state.response;
                        }


                      },
                        child:BlocBuilder<ShowsCubit,ShowsState>(builder: (context, state) {
                          if(state is ShowsListLoading){
                            // seriesCubit.seriesList();
                            return CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);
                          }
                          if(state is ShowsListLoaded){
                            seriesModel = state.response;
                            AppLog.f(seriesModel[0].categoryName);
                            return Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: seriesModel.length,
                                    itemBuilder: (context, index) {
                                      final SeriesModel series = seriesModel[index];

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:  EdgeInsets.only(left: 8.w),
                                                child: Text(series.categoryName,style: TextStyle(
                                                  fontFamily: 'GeoBook',
                                                  fontSize: 12.sp,
                                                  color: ColorConstantss.white,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              )),
                                          SingleChildScrollView(scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: series.data.map((e) {
                                                int index = series.data.indexOf(e);
                                                return
                                                  Container(
                                                    width: 120.w,
                                                    padding: EdgeInsets.only(left: index == 0 ? 8.w : 0,
                                                        right: 6.w,
                                                        top: 3.w
                                                    ),
                                                    child:
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {

                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowsEpisodeScreen(videoMapData: series.data[index].toJson(),)));
                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //     builder: (context) => MovieDetails(
                                                              //       model[modelIndex]!.videoId ?? "",
                                                              //     ),
                                                              //   ),
                                                              // );
                                                            },
                                                            child:
                                                            CatchImage(
                                                              imageUrl: "${Globals.imageBaseUrl}" + e.thumbnail,
                                                              height:125.h,
                                                              // systemHeight(12.h, context),
                                                              width: 120.w,
                                                              isFree:"0",
                                                            )
                                                        ),
                                                        SizedBox(height: 1.h),
                                                        SizedBox(
                                                          // width: 120.w,
                                                          child: Text(
                                                            // "bjhbjhfjvjvuhvjhhuhuvhfvhgfhgf",
                                                            e.title,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontFamily: 'GeoBook',
                                                              fontSize: 11.sp,
                                                              color: ColorConstantss.white,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                              }).toList(),
                                            ),)

                                        ],
                                      );}
                                ),
                              ],
                            );

                          }else{
                            return  CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);
                            // CupertinoActivityIndicator(color: Colors.red,radius: 13.r,);;
                          }
                        },) ,)


                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 15.h),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.delta.direction > 0) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const LanguageSelection()));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top:8.w,left: 8.w,bottom: 8.h,right: 5.w),
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.only
                              (topLeft: Radius.circular(15.r),bottomLeft: Radius.circular(15.r)),
                            color: const Color(0x7f262626)),
                        child: Row(mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back_ios,),
                            Image.asset(AppAsset.languageSelectionIcon,height: 20.h,width: 20.w,)
                      
                          ],),
                      ),
                    ),
                  ),
                )
              ],
            )
    );
  }

  Widget _text1(text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'GeoBook',
              fontSize: 12.sp,
              color: ColorConstantss.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAllMovie(
                      category: text,
                    ),
                  ));
              print(text);
            },
            child: Text(
              "View All",
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: 12.sp,
                color: ColorConstantss.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
  listBuild(
      String s,
      List<dynamic> model,
      ) {
    List<String> imgList2 = dynamicAdList.containsKey(s)
        ? dynamicAdList[s] as List<String>
        : imgListByDefaultAd;

    // Logger().d("GETED AD DATA ${imgList2.toList()}");
    return
      SizedBox(
        height: 150.h,
        child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.length + (model.length ~/ 4),
        itemBuilder: (BuildContext context, int index) {
          if (index % 5 == 4) {
            int imgIndex = index ~/ 5;
            imgIndex %= imgList2.length; // Wrap around imgList2 indices

            return InkWell(
              onTap: () {
                Logger().d("ON TAP IMAGEINDEX IS ${imgIndex}");
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(0.r)),
                    padding: EdgeInsets.only(top: 3.w,bottom: 3.w,right: 6.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image(
                        image: AssetImage(
                          // AppAsset.trialPoster
                          imgList2[imgIndex],
                        ),
                        height: 125.h,
                        // systemHeight(10.h, context),
                        width: 120.w,
                        fit: BoxFit.fill,

                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // For other indices, display model data
            int modelIndex = index - (index ~/ 5);
            return Container(
              padding: EdgeInsets.only(
                left: index == 0 ? 10.w : 0,
                right: 6.w,
                top: 3.w
              ),
              width: 120.w
              ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Logger().d(model.map((e) => e.thumbnail));
                      Logger().f(model[modelIndex]!.thumbnail);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(
                            model[modelIndex]!.videoId ?? "",
                          ),
                        ),
                      );
                    },
                    child: model[modelIndex].thumbnail != ""
                        ? CatchImage(
                      imageUrl: "${Globals.imageBaseUrl}" + model[modelIndex].thumbnail,
                      height:125.h,
                      // systemHeight(12.h, context),
                      width: 120.w,
                      isFree: model[modelIndex].free_movie,
                    )
                        : Image.asset(AppAsset.adsThumb3),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    // width: 120.w,
                    child: Text(
                      // "bjhbjhfjvjvuhvjhhuhuvhfvhgfhgf",
                      model[modelIndex].title ?? "",
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'GeoBook',
                        fontSize: 11.sp,
                        color: ColorConstantss.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
            ),
      );
  }

  Widget stackImageWithTab({required dynamic model}){
    return  CarouselSlider(
      options: CarouselOptions(
        autoPlayAnimationDuration:
        const Duration(seconds: 1),
        autoPlayCurve: Curves.linear,

        viewportFraction: 1,height: MediaQuery.sizeOf(context).height/2,
        autoPlay: true,
        reverse: false,
        autoPlayInterval:
        const Duration(seconds: 3),
        pauseAutoPlayOnTouch: true,
      ),
      items: List.generate(
        model.length,
            (index) {
          return Container(
            color: Colors.red,
            width: double.infinity,
            child:
            CachedNetworkImage(
              imageUrl: "${Globals.imageBaseUrl+model[index]}",
              placeholder: (context, url) =>  CupertinoActivityIndicator(
                radius: 8.r,color: ColorConstantss.red
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }

  Widget tabForHomeScreen({
    required String tabText,
    required void Function()? onTap,required int indexTab}){
    return   InkWell(
      onTap:onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 5.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color:indexTab == indexForTab  ? ColorConstantss.red : ColorConstantss.white,width: 2)),
          child: Text(tabText)),
    );
  }


}
