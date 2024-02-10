// import 'dart:async';
// import 'dart:developer';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:logger/logger.dart';
// import 'package:shinestreamliveapp/basescreen/base_screen.dart';
// import 'package:shinestreamliveapp/cubit_bloc/home_cubit/home_cubit.dart';
// import 'package:shinestreamliveapp/cubit_bloc/series_cubit/series_cubit.dart';
// import 'package:shinestreamliveapp/data/models/homebannermodel.dart';
// import 'package:shinestreamliveapp/data/models/seriesmodel.dart';
// import 'package:shinestreamliveapp/main.dart';
// import 'package:shinestreamliveapp/ui/dashboard/moviedetails.dart';
// import 'package:shinestreamliveapp/ui/dashboard/online_list.dart';
// import 'package:shinestreamliveapp/ui/dashboard/searchscreen.dart';
// import 'package:shinestreamliveapp/ui/dashboard/series_episode_screen.dart';
// import 'package:shinestreamliveapp/ui/dashboard/view_all_movie.dart';
// import 'package:shinestreamliveapp/ui/widget_components/catched_image.dart';
// import 'package:shinestreamliveapp/ui/widget_components/container_home.dart';
// import 'package:shinestreamliveapp/utils/app_assets.dart';
// import 'package:shinestreamliveapp/utils/app_log.dart';
// import 'package:shinestreamliveapp/utils/font_size_constants.dart';
// import 'package:shinestreamliveapp/utils/globle_var.dart';
//
// import '../../data/api.dart';
// import '../../data/models/seriesbannermodel.dart';
// import '../../di/locator.dart';
// import '../../utils/check_internet.dart';
// import '../../utils/color_constants.dart';
// import '../widget_components/app_bar_components.dart';
// import 'languageselection.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends BaseScreen<HomeScreen>
//     with TickerProviderStateMixin {
//   // InternetConnectionStatus? _connectionStatus;
//   // late StreamSubscription<InternetConnectionStatus> _subscription;
//   late TabController _controller;
//   final List<String> imgList = [
//     "assets/advertiseBanner/ads banner 1.png",
//     "assets/advertiseBanner/ads banner 2.png",
//     "assets/advertiseBanner/ads banner 3.png",
//
//     // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//     // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//     // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//     // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//     // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//     // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
//   ];
//   final List<String> imgListByDefaultAd = [
//     AppAsset.adsThumb1,
//     AppAsset.adsThumb2,
//     AppAsset.adsThumb3,
//   ];
//   final Map<String, dynamic> dynamicAdList = {
//     "Action Movies": [AppAsset.adsThumb1, AppAsset.adsThumb2],
//     "Classic Movies": [AppAsset.adsThumb3],
//   };
//   late List<HomeBannerModel> hbModel = [];
//   late List<SeriesModel> seriesModel = [];
//   late List<SeriesBannerModel> sbModel = [];
//   late List<ActionMovieModel> actionModel = [];
//   late List<ActionMovieModel> classicMovie = [];
//   late List<ActionMovieModel> comedyMovie = [];
//   late List<ActionMovieModel> crimeMovie = [];
//   late List<ActionMovieModel> romanticMovie = [];
//   late List<ActionMovieModel> telugufavMovie = [];
//   late List<ActionMovieModel> dramaMovie = [];
//   late List<ActionMovieModel> kidsMovie = [];
//   late List<ActionMovieModel> sportsMovie = [];
//   late List<ActionMovieModel> devotionalMovie = [];
//   late List<ActionMovieModel> folkSongs = [];
//   late List<ActionMovieModel> oldIsGold = [];
//   late List<ActionMovieModel> bestHollywood = [];
//   late List<ActionMovieModel> bestSouth = [];
//   var homeCubit = getIt<HomeCubit>();
//   var seriesCubit = getIt<SeriesCubit>();
//   bool isLoad = false;
//   bool isNoInternet = false;
//   bool servicestatus = false;
//   bool haspermission = false;
//   late LocationPermission permission;
//   late Position position;
//   String long = "", lat = "";
//   late StreamSubscription<Position> positionStream;
//
//   @override
//   void initState() {
//     // checkGps();
//     onCheckInternet(context).then((value) {
//       Logger().e(value);
//       homeCubit.homeBanner();
//     });
//     setState(() {
//       isLoad = true;
//     });
//     _controller = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   checkGps() async {
//     servicestatus = await Geolocator.isLocationServiceEnabled();
//     if (servicestatus) {
//       permission = await Geolocator.checkPermission();
//
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           print('Location permissions are denied');
//         } else if (permission == LocationPermission.deniedForever) {
//           print("'Location permissions are permanently denied");
//         } else {
//           haspermission = true;
//         }
//       } else {
//         haspermission = true;
//       }
//
//       if (haspermission) {
//         setState(() {
//           //refresh the UI
//         });
//
//         getLocation();
//       }
//     } else {
//       print("GPS Service is not enabled, turn on GPS location");
//     }
//
//     setState(() {
//       //refresh the UI
//     });
//   }
//
//   getLocation() async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     print(position.longitude);
//     print(position.latitude);
//
//     long = position.longitude.toString();
//     lat = position.latitude.toString();
//
//     setState(() {
//       //refresh UI
//     });
//
//     LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high, //accuracy of the location data
//       distanceFilter: 100, //minimum distance (measured in meters) a
//       //device must move horizontally before an update event is generated;
//     );
//
//     StreamSubscription<Position> positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings)
//             .listen((Position position) {
//       print(position.longitude); //Output: 80.24599079
//       print(position.latitude); //Output: 29.6593457
//
//       long = position.longitude.toString();
//       lat = position.latitude.toString();
//
//       setState(() {
//         //refresh UI on update
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     dynamic listeners = [
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is HBLoading) {
//             // CircularProgressIndicator(color: ColorConstants.red,);
//             // LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is HBLoaded) {
//             homeCubit.actionMovie();
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//             hbModel = state.response;
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is ActionLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is ActionLoaded) {
//             homeCubit.classicMovie();
//             actionModel = state.response;
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is ClassicLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is ClassicLoaded) {
//             classicMovie = state.response;
//             Logger().i(classicMovie[0].title);
//
//             homeCubit.comedyMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is ComedyLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is ComedyLoaded) {
//             comedyMovie = state.response;
//             homeCubit.crimeMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is CrimeLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is CrimeLoaded) {
//             crimeMovie = state.response;
//             homeCubit.romanticMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is RomanticLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is RomanticLoaded) {
//             romanticMovie = state.response;
//             homeCubit.telugufavMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is TeluguFavLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is TeluguFavLoaded) {
//             telugufavMovie = state.response;
//             homeCubit.dramaMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is DramaLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is DramaLoaded) {
//             dramaMovie = state.response;
//             homeCubit.kidsMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is KidsLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is KidsLoaded) {
//             kidsMovie = state.response;
//             homeCubit.sportsMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is SportsLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is SportsLoaded) {
//             sportsMovie = state.response;
//             homeCubit.devotionalMovie();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is DevotionalLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is DevotionalLoaded) {
//             devotionalMovie = state.response;
//             homeCubit.folkSongs();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is FolkLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is FolkLoaded) {
//             folkSongs = state.response;
//             homeCubit.oldIsGold();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is OldIsGoldLoading) {
//             //LoaderWidget.showProgressIndicatorAlertDialog(context);
//           } else if (state is OldIsGoldLoaded) {
//             oldIsGold = state.response;
//             homeCubit.bestHollywood();
//
//             //LoaderWidget.removeProgressIndicatorAlertDialog(context);
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is BestHollyLoading) {
//           } else if (state is BestHollyLoaded) {
//             bestHollywood = state.response;
//             homeCubit.bestSouth();
//
//           }
//         },
//       ),
//       BlocListener<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is BestSouthLoading) {
//             isLoad = false;
//             setState(() {});
//           } else if (state is BestSouthLoaded) {
//             bestSouth = state.response;
//
//           }
//         },
//       ),
//
//     ];
//
//     // Logger().i("${servicestatus? "GPS is Service Enabled": "GPS is Service disabled."}"
//     //     "::${haspermission? "GPS is Permission Enabled": "GPS is Permission disabled."}::"
//     //     "${"Longitude: $long"}::${"Latitude: $lat"}");
//
//     Future<void> _onRefresh() async {
//       homeCubit.homeBanner();
//       setState(() {
//         isLoad = true;
//       });
//       Logger().f('refreshing stocks...');
//     }
//
//     return Scaffold(
//         appBar: AppBarConstant(
//             isLeading: false,
//             Padding(
//               padding: EdgeInsets.only(right: 10.w),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LanguageSelection(),
//                       ));
//                 },
//                 child: Icon(
//                   Icons.language_outlined,
//                   color: ColorConstantss.red,
//                 ),
//               ),
//             ), () {
//           // Navigator.pop(context);
//         }),
//         body:
//             // GlobleVar().isInternet?
//
//             MultiBlocListener(
//           listeners: listeners,
//           child: Column(
//             children: [
//               SingleChildScrollView(
//                 child: Expanded(
//                   child: TabBar(
//                       padding: EdgeInsets.only(left: 15.w, right: 15.w),
//                       controller: _controller,
//                       indicatorColor: ColorConstantss.red,
//                       indicatorWeight: 1,
//                       unselectedLabelColor: ColorConstantss.white.withOpacity(0.8),
//                       labelColor: ColorConstantss.red,
//                       overlayColor: MaterialStatePropertyAll(Colors.transparent),
//                       tabs: [
//                         Tab(
//                           child: _text("Movie"),
//                         ),
//                         // Tab(
//                         //   child: _text("TV Show"),
//                         // ),
//                         Tab(
//                           child: _text("Series"),
//                         ),
//                       ]),
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                       controller: _controller,
//                       children: <Widget>[
//                         RefreshIndicator(
//                           onRefresh: _onRefresh,color: ColorConstantss.red,
//                           child: BlocBuilder<HomeCubit, HomeState>(
//                             builder: (context, state) {
//                               if (state is BestSouthLoaded) {
//                                 Logger().d("sdvrheh");
//                                 return SingleChildScrollView(
//                                   child: Column(
//                                     // mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CarouselSlider(
//                                         options: CarouselOptions(
//                                           autoPlayAnimationDuration:
//                                               Duration(seconds: 1),
//                                           autoPlayCurve: Curves.linear,
//                                           viewportFraction: 1,
//                                           autoPlay: true,
//                                           reverse: false,
//                                           autoPlayInterval:
//                                               Duration(seconds: 3),
//                                           pauseAutoPlayOnTouch: true,
//                                         ),
//                                         items: List.generate(
//                                           hbModel.length +
//                                               (hbModel.length ~/ 2),
//                                           (index) {
//                                             if (index % 3 == 2) {
//                                               int imgIndex = index ~/ 3;
//                                               imgIndex %= imgList.length;
//                                               return InkWell(
//                                                 onTap: () {
//                                                   Logger().d(imgList[imgIndex]);
//                                                 },
//                                                 child: Container(
//                                                   margin: EdgeInsets.all(6.w),
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.r),
//                                                   ),
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.r),
//                                                     child: Image(
//                                                       image: AssetImage(
//                                                           // AppAsset.trialPoster
//                                                           imgList[imgIndex]),
//                                                       height: 120.h,
//                                                       width: double.infinity,
//                                                       fit: BoxFit.fill,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             } else {
//                                               // For other indices, display model data
//                                               int modelIndex = index ~/ 3;
//                                               return InkWell(
//                                                 onTap: () {
//                                                   Logger().d(hbModel[modelIndex]
//                                                       .toJson());
//                                                 },
//                                                 child: Container(
//                                                   margin: EdgeInsets.all(6.w),
//                                                   height: 120.h,
//                                                   width: double.infinity,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.r),
//                                                     image: DecorationImage(
//                                                       image: NetworkImage(
//                                                           "${Globals.imageBaseUrl}" +
//                                                               hbModel[modelIndex]
//                                                                   .thumbnail!),
//                                                       fit: BoxFit.fill,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             }
//                                           },
//                                         ),
//                                       ),
//
//                                       // CarouselSlider(
//                                       //   options: CarouselOptions(
//                                       //     autoPlayAnimationDuration: Duration(seconds: 1),
//                                       //     autoPlayCurve: Curves.linear,viewportFraction: 1,
//                                       //     autoPlay: true,
//                                       //     reverse: false,
//                                       //     autoPlayInterval: Duration(seconds: 3),
//                                       //     pauseAutoPlayOnTouch: true,
//                                       //   ),
//                                       //   items: hbModel
//                                       //       .map((item) =>
//                                       //
//                                       //       InkWell(
//                                       //
//                                       //         onTap:(){
//                                       //           Logger().d(item.toJson());
//                                       //         },
//                                       //         child: Container(
//                                       //               margin: EdgeInsets.all(6),
//                                       //               height: 120,
//                                       //               // height: systemHeight(10, context),
//                                       //               width: double.infinity,
//                                       //               decoration: BoxDecoration(
//                                       //                 borderRadius:
//                                       //                     BorderRadius.circular(8.0),
//                                       //                 image: DecorationImage(
//                                       //                   image:
//                                       //                   NetworkImage(
//                                       //                       "${Globals.imageBaseUrl}" +
//                                       //                           item.thumbnail!),
//                                       //                   fit: BoxFit.fill,
//                                       //                 ),
//                                       //               ),
//                                       //             ),
//                                       //       )
//                                       //   )
//                                       //       .toList(),
//                                       // ),
//                                       SizedBox(
//                                         height: 20.h,
//                                       ),
//                                       _text1("Action Movies"),
//                                       listBuild(
//                                         "Action Movies",
//                                         actionModel,
//                                       ),
//                                       _text1("Classic Movies"),
//                                       listBuild("Classic Movies", classicMovie),
//                                       _text1("Comedy Movies"),
//                                       listBuild("Comedy Movies", comedyMovie),
//                                       _text1("Crime Movies"),
//                                       listBuild(
//                                         "Crime Movies",
//                                         crimeMovie,
//                                       ),
//                                       _text1("Romantic Movies"),
//                                       listBuild(
//                                         "Romantic Movies",
//                                         romanticMovie,
//                                       ),
//                                       _text1("Telugu Fav Movies"),
//                                       listBuild(
//                                         "Telugu Fav Movies",
//                                         telugufavMovie,
//                                       ),
//                                       _text1("Drama Movies"),
//                                       listBuild(
//                                         "Drama Movies",
//                                         dramaMovie,
//                                       ),
//                                       _text1("Kids Movies"),
//                                       listBuild(
//                                         "Kids Movies",
//                                         kidsMovie,
//                                       ),
//                                       _text1("Sports Movies"),
//                                       listBuild(
//                                         "Sports Movies",
//                                         sportsMovie,
//                                       ),
//                                       _text1("Devotional Movies"),
//                                       listBuild(
//                                         "Devotional Movies",
//                                         devotionalMovie,
//                                       ),
//                                       _text1("Folk Songs"),
//                                       listBuild(
//                                         "Folk Songs",
//                                         folkSongs,
//                                       ),
//                                       _text1("Old Is Gold"),
//                                       listBuild(
//                                         "Old Is Gold",
//                                         oldIsGold,
//                                       ),
//                                       _text1("Best Hollywood"),
//                                       listBuild(
//                                           "Best Hollywood", bestHollywood),
//                                       _text1("Best South"),
//                                       listBuild("Best South", bestSouth),
//                                     ],
//                                   ),
//                                 );
//                               } else {
//                                 return Container();
//                               }
//                             },
//                           ),
//                         ),
//                         BlocBuilder<SeriesCubit, SeriesState>(
//                           builder: (context, state) {
//                             if (state is SBLoading) {
//                               seriesCubit.seriesBanner();
//                               AppLog.e("Series cubit loading");
//                             }
//                             if (state is SBLoaded) {
//                               sbModel = state.response;
//                               seriesCubit.seriesList();
//                               Logger().d("MODEL LENGTH${sbModel.length}");
//                             }
//                             if (state is SeriesLoaded) {
//
//                               seriesModel = state.response;
//                               return SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CarouselSlider(
//                                       options: CarouselOptions(
//                                         autoPlayAnimationDuration:
//                                             Duration(seconds: 1),
//                                         autoPlayCurve: Curves.linear,
//                                         viewportFraction: 1,
//                                         autoPlay: true,
//                                         reverse: false,
//                                         autoPlayInterval: Duration(seconds: 3),
//                                         pauseAutoPlayOnTouch: true,
//                                       ),
//                                       items: sbModel
//                                           .map((item) => InkWell(
//                                                 onTap: () {
//
//
//                                                   // Navigator.push(
//                                                   //   context,
//                                                   //   MaterialPageRoute(
//                                                   //     builder: (context) => MovieDetails(item.videoId??""),
//                                                   //   ),
//                                                   // );
//                                                 },
//                                                 child: Container(
//                                                   margin: EdgeInsets.all(6.w),
//                                                   height: systemHeight(
//                                                       10.h, context),
//                                                   width: systemWidth(
//                                                       100.w, context),
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.r),
//                                                     image: DecorationImage(
//                                                       image:
//                                                           // item.thumbnail.
//                                                           NetworkImage(
//                                                               "${Globals.imageBaseUrl}" +
//                                                                   item.thumbnail),
//                                                       fit: BoxFit.fill,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     ),
//                                     SizedBox(
//                                       height: 20.h,
//                                     ),
//                                     Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 8.w),
//                                       child: GridView.builder(
//                                           scrollDirection: Axis.vertical,
//                                           physics: ScrollPhysics(),
//                                           shrinkWrap: true,
//                                           gridDelegate:
//                                                SliverGridDelegateWithFixedCrossAxisCount(
//                                             childAspectRatio: 0.5.h,
//                                             crossAxisSpacing: 10.w,
//                                             crossAxisCount: 3,
//                                                  mainAxisSpacing: 10.w
//                                           ),
//                                           itemCount: seriesModel.length,
//                                           itemBuilder:
//                                               (BuildContext ctx, index) {
//                                             return Container(
//                                               // color: ColorConstants.red,
//                                               // height: 300,
//                                               // height: systemHeight(20, context),
//                                               // width: 100,
//                                               // padding: EdgeInsets.symmetric(horizontal: 15),
//                                               child: Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 // mainAxisAlignment: MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     height: systemHeight(14.h, context),
//                                                     child: InkWell(
//                                                         onTap: () {
//                                                           Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                 builder: (context) =>
//                                                                     MovieDetails(
//                                                                         seriesModel[index]
//                                                                                 .videoId ??
//                                                                             ""),
//                                                               ));
//                                                         },
//                                                         child:
//                                                             CatchImageWithOutWidth(
//                                                           imageUrl:
//                                                               "${Globals.imageBaseUrl}${seriesModel[index].thumbnail}",
//                                                           // height: 100.h,
//                                                           // systemHeight(11.h, context),
//                                                           isFree: "0",
//                                                         )
//                                                         // Container(
//                                                         //
//                                                         //
//                                                         //   height: systemHeight(15, context),
//                                                         //   // width: 80,
//                                                         //   decoration: BoxDecoration(
//                                                         //       borderRadius: BorderRadius.circular(8),
//                                                         //       image: DecorationImage(fit: BoxFit.fill,image:
//                                                         //       NetworkImage("${Globals.imageBaseUrl}"+ newList[index].thumbnail!,),
//                                                         //       )),
//                                                         // ),
//                                                         ),
//                                                   ),
//                                                   SizedBox(height: 1.h),
//                                                   Expanded(
//                                                     child: Text(
//                                                       // "modelmodelmodelmodascefelmoddffasfwel",
//                                                       seriesModel[index]
//                                                               .title ??
//                                                           "",
//                                                       maxLines: 1,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: TextStyle(
//                                                         fontFamily: 'GeoBook',
//                                                         fontSize: 11.sp,
//                                                         color: ColorConstantss
//                                                             .white,
//                                                         fontWeight:
//                                                             FontWeight.normal,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                             //   InkWell(
//                                             //   onTap: (){
//                                             //     Logger().f(seriesModel[index].toJson());
//                                             //     // Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesEpisodeScreen(videoMapData: seriesModel[index].toJson(),)));
//                                             //     // Navigato  r.push(
//                                             //     //     context,
//                                             //     //     MaterialPageRoute(
//                                             //     //       builder: (context) => MovieDetails(seriesModel[index].videoId??""),
//                                             //     //     ));
//                                             //   },
//                                             //   child: Column(
//                                             //     mainAxisSize: MainAxisSize.min,
//                                             //
//                                             //     children: [
//                                             //       Text("data"),
//                                             //       Container(
//                                             //         // height: 100,
//                                             //         child: Image.network(
//                                             //           "${Globals.imageBaseUrl}" +
//                                             //               seriesModel[index].thumbnail!,
//                                             //           fit: BoxFit.fill,
//                                             //           height: 100,
//                                             //         ),
//                                             //       ),
//                                             //     ],
//                                             //   ),
//                                             // );
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             } else {
//                               return Container();
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//               )
//             ],
//           ))
//
//         );
//   }
//
//   Widget _text(text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontFamily: 'GeoBook',
//         fontSize: 12.sp,
//         // color: ColorConstantss.red,
//         fontWeight: FontWeight.w400,
//       ),
//     );
//   }
//
//   Widget _text1(text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontFamily: 'GeoBook',
//               fontSize: 12.sp,
//               color: ColorConstantss.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ViewAllMovie(
//                       category: text,
//                     ),
//                   ));
//               print(text);
//             },
//             child: Text(
//               "View All",
//               style: TextStyle(
//                 fontFamily: 'GeoBook',
//                 fontSize: 12.sp,
//                 color: ColorConstantss.white,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   listBuild(
//       String s,
//       List<dynamic> model,
//       ) {
//     List<String> imgList2 = dynamicAdList.containsKey(s)
//         ? dynamicAdList[s] as List<String>
//         : imgListByDefaultAd;
//
//     // Logger().d("GETED AD DATA ${imgList2.toList()}");
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child:
//       Row(
//           mainAxisSize: MainAxisSize.min,
//           children:
//           List.generate(model.length, (index) {
//             return InkWell(
//               onTap: (){
//                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => MovieDetails(
//                                         model[index]!.videoId ?? "",
//                                       ),
//                                     ),
//                                   );
//                 print(model[index]);
//
//                 Logger().f(model[index]);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MovieDetails(
//                       model[index].videoId ?? "",
//                     ),
//                   ),
//                 );
//
//               },
//               child: SizedBox(
//                 width: 120.w,
//                 child: Padding(
//                   padding: EdgeInsets.all(3.w),
//                   child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8.r),
//                         child: CatchImage(
//                           width: 120.w,
//                           height: 125.h,
//
//                           imageUrl: "${Globals.imageBaseUrl + model[index].thumbnail}",
//                            isFree: "0",
//                         ),
//                       ),
//                       Text(
//                         "${model[index].title}",
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           })
//       ),
//     );
//  ///       for showing ad with movie list  ///
//
//   // listBuild(String s, List<dynamic> model) {
//   //   List<String> imgList2 = dynamicAdList.containsKey(s)
//   //       ? dynamicAdList[s] as List<String>
//   //       : imgListByDefaultAd;
//   //
//   //   return SingleChildScrollView(
//   //     scrollDirection: Axis.horizontal,
//   //     child: Row(
//   //       mainAxisSize: MainAxisSize.min,
//   //       children:
//
//         // List.generate(model.length + (model.length ~/ 4), (index) {
//         //   if (index % 5 == 4) {
//         //     // If index is a multiple of 4, show item from imgList2
//         //     int imgIndex = index ~/ 5;
//         //     imgIndex %= imgList2.length;
//         //     return InkWell(
//         //       onTap: () {
//         //         Logger().f(imgList2[imgIndex]);
//         //         // Handle onTap for imgList2 item
//         //       },
//         //       child: SizedBox(
//         //         width: 120.w,
//         //         child: Padding(
//         //           padding: EdgeInsets.all(3.w),
//         //           child: Column(
//         //             mainAxisSize: MainAxisSize.min,
//         //             children: [
//         //               ClipRRect(
//         //                 borderRadius: BorderRadius.circular(8.r),
//         //                 child:
//         //                   Image.asset(imgList2[imgIndex],height: 125.h,width: 120.w,fit: BoxFit.fill,)
//         //                   // when data comes from data base
//         //                 // CachedNetworkImage(
//         //                 //   width: 120.w,
//         //                 //   height: 125.h,
//         //                 //   fit: BoxFit.fill,
//         //                 //   imageUrl: "${Globals.imageBaseUrl + imgList2[imgIndex]}",
//         //                 //   placeholder: (context, url) =>
//         //                 //       CircularProgressIndicator(),
//         //                 //   errorWidget: (context, url, error) => Icon(Icons.error),
//         //                 // ),
//         //               ),
//         //               Text(
//         //                 "vgfgvygfghvvhguhfyucghgchg",
//         //                 maxLines: 1,
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     );
//         //   } else {
//         //     // Otherwise, show item from model
//         //     int modelIndex = index - (index ~/ 5);
//         //     return InkWell(
//         //       onTap: () {
//         //         Logger().f(model[modelIndex]);
//         //         // Handle onTap for model item
//         //         Navigator.push(
//         //           context,
//         //           MaterialPageRoute(
//         //             builder: (context) => MovieDetails(
//         //               model[modelIndex].videoId ?? "",
//         //             ),
//         //           ),
//         //         );
//         //       },
//         //       child: SizedBox(
//         //         width: 120.w,
//         //         child: Padding(
//         //           padding: EdgeInsets.all(3.w),
//         //           child: Column(
//         //             mainAxisSize: MainAxisSize.min,
//         //             children: [
//         //               ClipRRect(
//         //                 borderRadius: BorderRadius.circular(8.r),
//         //                 child: CachedNetworkImage(
//         //                   width: 120.w,
//         //                   height: 125.h,
//         //                   fit: BoxFit.fill,
//         //                   imageUrl: "${Globals.imageBaseUrl + model[modelIndex].thumbnail}",
//         //                   placeholder: (context, url) =>
//         //                       CircularProgressIndicator(),
//         //                   errorWidget: (context, url, error) => Icon(Icons.error),
//         //                 ),
//         //               ),
//         //               SizedBox(
//     //                         height: 30.w,
//     //                         child: Text(
//     //                           "${model[index].title}",
//     //                           maxLines: 1,
//     //                         ),
//     //                       )
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     );
//         //   }
//         // }),
//       // ),
//     // );
//
// /// ad with movie list view builder
//     // ListView.builder(
//     //   shrinkWrap: true,
//     //   scrollDirection: Axis.horizontal,
//     //   itemCount: model.length + (model.length ~/ 4),
//     //   itemBuilder: (BuildContext context, int index) {
//     //     if (index % 5 == 4) {
//     //       int imgIndex = index ~/ 5;
//     //       imgIndex %= imgList2.length; // Wrap around imgList2 indices
//     //
//     //       return InkWell(
//     //         onTap: () {
//     //           Logger().d("ON TAP IMAGEINDEX IS ${imgIndex}");
//     //         },
//     //         child: Column(
//     //           mainAxisSize: MainAxisSize.min,
//     //           children: [
//     //             Container(
//     //               // decoration: BoxDecoration(borderRadius: BorderRadius.circular(0.r)),
//     //               padding: EdgeInsets.only(top: 3.w,bottom: 3.w,right: 6.w),
//     //               child: ClipRRect(
//     //                 borderRadius: BorderRadius.circular(8.r),
//     //                 child: Image(
//     //                   image: AssetImage(
//     //                     // AppAsset.trialPoster
//     //                     imgList2[imgIndex],
//     //                   ),
//     //                   height: 100.h,
//     //                   // systemHeight(10.h, context),
//     //                   width: 120.w,
//     //                   fit: BoxFit.fill,
//     //
//     //                 ),
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //       );
//     //     } else {
//     //       // For other indices, display model data
//     //       int modelIndex = index - (index ~/ 5);
//     //       return Container(
//     //         padding: EdgeInsets.only(
//     //           left: index == 0 ? 10.w : 0,
//     //           right: 6.w,
//     //           top: 3.w
//     //         ),
//     //         // color: Colors.blue,
//     //         width: 120.w
//     //         ,
//     //         // padding: EdgeInsets.all(3.w),
//     //         child: Column(
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           children: [
//     //             InkWell(
//     //               onTap: () {
//     //                 Logger().d(model.map((e) => e.thumbnail));
//     //                 Logger().f(model[modelIndex]!.thumbnail);
//     //                 Navigator.push(
//     //                   context,
//     //                   MaterialPageRoute(
//     //                     builder: (context) => MovieDetails(
//     //                       model[modelIndex]!.videoId ?? "",
//     //                     ),
//     //                   ),
//     //                 );
//     //               },
//     //               child: model[modelIndex].thumbnail != ""
//     //                   ? CatchImage(
//     //                 imageUrl: "${Globals.imageBaseUrl}" + model[modelIndex].thumbnail,
//     //                 height:100.h,
//     //                 // systemHeight(12.h, context),
//     //                 width: 120.w,
//     //                 isFree: false,
//     //               )
//     //                   : Image.asset(AppAsset.adsThumb3),
//     //             ),
//     //             SizedBox(height: 1.h),
//     //             SizedBox(
//     //               // width: 120.w,
//     //               child: Text(
//     //                 // "bjhbjhfjvjvuhvjhhuhuvhfvhgfhgf",
//     //                 model[modelIndex].title ?? "",
//     //                 maxLines: 2.bitLength,
//     //                 softWrap: true,
//     //                 overflow: TextOverflow.ellipsis,
//     //                 style: TextStyle(
//     //                   fontFamily: 'GeoBook',
//     //                   fontSize: 11.sp,
//     //                   color: ColorConstantss.white,
//     //                   fontWeight: FontWeight.normal,
//     //                 ),
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //       );
//     //     }
//     //   },
//     // )
//
//     //     ListView.builder(
//     // shrinkWrap: true,
//     // scrollDirection: Axis.horizontal,
//     // itemCount: model.length,
//     // itemBuilder: (BuildContext context, int index) {
//     //   return
//     //     Container(
//     //       // color: Colors.blue,
//     //       // height: systemHeight(18, context),
//     //       width: 120,
//     //       padding: EdgeInsets.all(5.0),
//     //       child: Column(
//     //         // mainAxisAlignment: MainAxisAlignment.start,
//     //         crossAxisAlignment: CrossAxisAlignment.start,
//     //         children: [
//     //           InkWell(
//     //             onTap: (){
//     //               // Navigator.push(context, MaterialPageRoute(builder: (context) => OnlineList(),));
//     //               Navigator.push(
//     //                             context,
//     //                             MaterialPageRoute(
//     //                               builder: (context) => MovieDetails(
//     //                                   model[index]!.videoId??""
//     //                               ),
//     //                             ),
//     //                           );
//     //             },
//     //             child:CatchImage(imageUrl: "${Globals.imageBaseUrl}"+
//     //                           model[index].thumbnail, height: systemHeight(15, context),
//     //               width: 120,
//     //               isFree:false,
//     //               // model[index].title == "Hitler"?true:false ,
//     //             )
//     //           ),
//     //           SizedBox(height: 5.0),
//     //           Expanded(
//     //             child: Text(
//     //               // "modelmodelmodelmodelmodel",
//     //               model[index].title??"",
//     //               maxLines: 2,softWrap: true,
//     //               overflow: TextOverflow.ellipsis,
//     //               style: TextStyle(
//     //                 fontFamily: 'GeoBook',
//     //                 fontSize: 12,
//     //                 color: ColorConstantss.white,
//     //                 fontWeight: FontWeight.normal,
//     //               ),
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     );
//     // }
//     //       )
//   }
// }
