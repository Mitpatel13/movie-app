import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/home_cubit/home_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/series_cubit/series_cubit.dart';
import 'package:shinestreamliveapp/data/models/homebannermodel.dart';
import 'package:shinestreamliveapp/data/models/seriesmodel.dart';
import 'package:shinestreamliveapp/data/repository/homerepository.dart';
import 'package:shinestreamliveapp/data/services/homeservice.dart';
import 'package:shinestreamliveapp/main.dart';
import 'package:shinestreamliveapp/ui/dashboard/moviedetails.dart';
import 'package:shinestreamliveapp/ui/dashboard/online_list.dart';
import 'package:shinestreamliveapp/ui/dashboard/searchscreen.dart';
import 'package:shinestreamliveapp/ui/dashboard/series_episode_screen.dart';
import 'package:shinestreamliveapp/ui/dashboard/view_all_movie.dart';
import 'package:shinestreamliveapp/ui/widget_components/catched_image.dart';
import 'package:shinestreamliveapp/ui/widget_components/container_home.dart';
import 'package:shinestreamliveapp/utils/font_size_constants.dart';
import 'package:shinestreamliveapp/utils/globle_var.dart';

import '../../data/api.dart';
import '../../data/models/seriesbannermodel.dart';
import '../../di/locator.dart';
import '../../utils/check_internet.dart';
import '../../utils/color_constants.dart';
import '../widget_components/app_bar_components.dart';
import 'languageselection.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen>
    with TickerProviderStateMixin {
  // InternetConnectionStatus? _connectionStatus;
  // late StreamSubscription<InternetConnectionStatus> _subscription;
  late TabController _controller;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  List<String> movieName = [
    "Movie1",
    "Movie2",
    "Movie3",
    "Movie4",
    "Movie5",
    "Movie6"
  ];
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
  bool isLoad = false;
  bool isNoInternet = false;

  @override
  void initState() {
    onCheckInternet(context).then((value) {
      Logger().e(value);
      homeCubit.homeBanner();
    });
    // onCheckInternet(setState);

    // HomeService().languageAPi();
    setState(() {
      isLoad = true;

    });

    // onCheckInternet();


    _controller = TabController(length: 2, vsync: this);
    // TODO: implement initState

    super.initState();
  }
  // onCheckInternet()async{
  //   _subscription = InternetConnectionCheckerPlus().onStatusChange.listen((status) {
  //     setState(() {
  //       _connectionStatus = status;
  //       Logger().d("INTERNET STATUS ::${status}");
  //     });
  // });}
  @override
  Widget build(BuildContext context) {

    Future<void> _onRefresh() async{
      homeCubit.homeBanner();
      setState(() {
        isLoad = true;

      });
      Logger().f('refreshing stocks...');

    }
    return Scaffold(
          appBar:AppBarConstant(
      isLeading: false,
    Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelection(),
                  ));
            },
            child: Icon(
              Icons.language_outlined,
              color: ColorConstantss.red,
            ),),
    ),(){
    // Navigator.pop(context);
      }),
        body:
          // GlobleVar().isInternet?

          RefreshIndicator(onRefresh:_onRefresh,color: ColorConstantss.red,

    child: SingleChildScrollView(
        child: MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HBLoading) {
              // CircularProgressIndicator(color: ColorConstants.red,);
              // LoaderWidget.showProgressIndicatorAlertDialog(context);
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
              //LoaderWidget.showProgressIndicatorAlertDialog(context);
            } else if (state is BestHollyLoaded) {
              bestHollywood = state.response;
              homeCubit.bestSouth();

              //LoaderWidget.removeProgressIndicatorAlertDialog(context);
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is BestSouthLoading) {
              isLoad = false;setState(() {

              });
              // CupertinoActivityIndicator(animating: true,color: ColorConstants.red,);
              // showAboutDialog(context: context,children: [Text("data")]);
              // CircularProgressIndicator(color: ColorConstants.red,);
              //LoaderWidget.showProgressIndicatorAlertDialog(context);
            } else if (state is BestSouthLoaded) {
              bestSouth = state.response;

              //LoaderWidget.removeProgressIndicatorAlertDialog(context);
            }
          },
        ),
      ],
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: TabBar(
                padding: EdgeInsets.only(left: 15, right: 15),
                controller: _controller,
                indicatorColor: ColorConstantss.red,
                indicatorWeight: 1,
                unselectedLabelColor: ColorConstantss.heading,

                labelColor: ColorConstantss.red,overlayColor: MaterialStatePropertyAll(Colors.transparent),
                tabs: [
                  Tab(
                    child: _text("Movie"),
                  ),
                  // Tab(
                  //   child: _text("TV Show"),
                  // ),
                  Tab(
                    child: _text("Series"),
                  ),
                ]),
          ),
          isLoad ?  Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height / 3,),
              CupertinoActivityIndicator(color: ColorConstantss.red,animating: true,radius: 15,),
            ],
          ):
          Container(
            height: MediaQuery.sizeOf(context).height *3.8,
            // height: systemHeight(600, context),
            // margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is BestSouthLoaded) {
                      return
                        Column(

                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayCurve: Curves.linear,viewportFraction: 1,
                              autoPlay: true,
                              reverse: false,
                              autoPlayInterval: Duration(seconds: 3),
                              pauseAutoPlayOnTouch: true,
                            ),
                            items: hbModel
                                .map((item) =>

                                InkWell(

                                  onTap:(){
                                    Logger().d(item.toJson());
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => MovieDetails(item.videoId.toString()),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                        margin: EdgeInsets.all(6),
                                        height: 120,
                                        // height: systemHeight(10, context),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image:
                                            NetworkImage(
                                                "${Globals.imageBaseUrl}" +
                                                    item.thumbnail!),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                )
                            )
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _text1("Action Movies"),
                          listBuild("Action Movies", actionModel, movieName),
                          _text1("Classic Movies"),
                          listBuild("Action Movies", classicMovie, movieName),
                          _text1("Comedy Movies"),
                          listBuild("Action Movies", comedyMovie, movieName),
                          _text1("Crime Movies"),
                          listBuild("Action Movies", crimeMovie, movieName),
                          _text1("Romantic Movies"),
                          listBuild(
                              "Action Movies", romanticMovie, movieName),
                          _text1("Telugu Fav Movies"),
                          listBuild(
                              "Action Movies", telugufavMovie, movieName),
                          _text1("Drama Movies"),
                          listBuild("Action Movies", dramaMovie, movieName),
                          _text1("Kids Movies"),
                          listBuild("Action Movies", kidsMovie, movieName),
                          _text1("Sports Movies"),
                          listBuild("Action Movies", sportsMovie, movieName),
                          _text1("Devotional Movies"),
                          listBuild(
                              "Action Movies", devotionalMovie, movieName),
                          _text1("Folk Songs"),
                          listBuild("Action Movies", folkSongs, movieName),
                          _text1("Old Is Gold"),
                          listBuild("Action Movies", oldIsGold, movieName),
                          _text1("Best Hollywood"),
                          listBuild(
                              "Action Movies", bestHollywood, movieName),
                          _text1("Best South"),
                          listBuild("Action Movies", bestSouth, movieName),


                          // _text1("Best South"),
                          // listBuild("Action Movies", bestSouth, movieName),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),

                BlocBuilder  <SeriesCubit, SeriesState>(
                  builder: (context, state) {
                    if (state is SBLoading) {

                      seriesCubit.seriesBanner();
                    }
                    if (state is SBLoaded) {
                      sbModel = state.response;
                      seriesCubit.seriesList();
                      Logger().d(sbModel.length);
                    }
                    if (state is SeriesLoaded) {
                      seriesModel = state.response;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayCurve: Curves.linear,viewportFraction: 1,
                              autoPlay: true,
                              reverse: false,
                              autoPlayInterval: Duration(seconds: 3),
                              pauseAutoPlayOnTouch: true,
                            ),
                            items: sbModel
                                .map((item) => InkWell(
                              onTap:(){
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MovieDetails(item.videoId??""),
                                //   ),
                                // );
                              },
                              child: Container(
                                        margin: EdgeInsets.all(6),
                                        height: systemHeight(10, context),
                                        width: systemWidth(100, context),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image:
                                          DecorationImage(
                                            image:
                                            NetworkImage(
                                                "${Globals.imageBaseUrl}" +
                                                    item.thumbnail),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 3,
                                    ),
                                itemCount: seriesModel.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return  Container(
                                    // color: ColorConstants.red,
                                    // height: 300,
                                    // height: systemHeight(20, context),
                                    // width: 100,
                                    // padding: EdgeInsets.symmetric(horizontal: 15),
                                    child:
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            onTap:(){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => MovieDetails(seriesModel[index].videoId??""),
                                                  ));
                                            },
                                            child:
                                            CatchImageWithOutWidth(
                                              imageUrl: "${Globals.imageBaseUrl}${seriesModel[index].thumbnail}",
                                              height:  systemHeight(15, context), isFree: false, )
                                          // Container(
                                          //
                                          //
                                          //   height: systemHeight(15, context),
                                          //   // width: 80,
                                          //   decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(8),
                                          //       image: DecorationImage(fit: BoxFit.fill,image:
                                          //       NetworkImage("${Globals.imageBaseUrl}"+ newList[index].thumbnail!,),
                                          //       )),
                                          // ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Expanded(
                                          child: Text(
                                            // "modelmodelmodelmodascefelmoddffasfwel",
                                            seriesModel[index].title??"",
                                            maxLines: 2,softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'GeoBook',
                                              fontSize: 12,
                                              color: ColorConstantss.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  //   InkWell(
                                  //   onTap: (){
                                  //     Logger().f(seriesModel[index].toJson());
                                  //     // Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesEpisodeScreen(videoMapData: seriesModel[index].toJson(),)));
                                  //     // Navigato  r.push(
                                  //     //     context,
                                  //     //     MaterialPageRoute(
                                  //     //       builder: (context) => MovieDetails(seriesModel[index].videoId??""),
                                  //     //     ));
                                  //   },
                                  //   child: Column(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //
                                  //     children: [
                                  //       Text("data"),
                                  //       Container(
                                  //         // height: 100,
                                  //         child: Image.network(
                                  //           "${Globals.imageBaseUrl}" +
                                  //               seriesModel[index].thumbnail!,
                                  //           fit: BoxFit.fill,
                                  //           height: 100,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),

    )),
          )
        );
  }

  Widget _text(text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'GeoBook',
        fontSize: 14,
        // color: ColorConstantss.red,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _text1(text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: 14,
                color: ColorConstantss.white,
                fontWeight: FontWeight.w500,
              ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovie(category: text,),));
              print(text);
            },
            child: Text(
              "View All",
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: 14,
                color: ColorConstantss.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  listBuild(String s, List<dynamic> model, List<String> movieName,) {
    return
      Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model.length,
      itemBuilder: (BuildContext context, int index) {
        return
          Container(
            // color: Colors.blue,
            // height: systemHeight(18, context),
            width: 120,
            padding: EdgeInsets.all(5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => OnlineList(),));
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                        model[index]!.videoId??""
                                    ),
                                  ),
                                );
                  },
                  child:CatchImage(imageUrl: "${Globals.imageBaseUrl}"+
                                model[index].thumbnail, height: systemHeight(15, context),
                    width: 120,
                    isFree:false,
                    // model[index].title == "Hitler"?true:false ,
                  )
                ),
                SizedBox(height: 5.0),
                Expanded(
                  child: Text(
                    // "modelmodelmodelmodelmodel",
                    model[index].title??"",
                    maxLines: 2,softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'GeoBook',
                      fontSize: 12,
                      color: ColorConstantss.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
      }
            ));
  }

}


