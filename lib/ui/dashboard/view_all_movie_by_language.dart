import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/ui/widget_components/app_bar_components.dart';
import 'package:shinestreamliveapp/ui/widget_components/catched_image.dart';

import '../../cubit_bloc/view_all_movies_cubit/view_all_movie_cubit.dart';
import '../../cubit_bloc/view_all_movies_cubit/view_all_movie_state.dart';
import '../../data/api.dart';
import '../../data/models/homebannermodel.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import 'moviedetails.dart';
class ViewAllMovieByLanguage extends StatefulWidget {

  const ViewAllMovieByLanguage({super.key});

  @override
  State<ViewAllMovieByLanguage> createState() => _ViewAllMovieByLanguageState();
}

class _ViewAllMovieByLanguageState extends BaseScreen<ViewAllMovieByLanguage> {
  late List<ActionMovieModel> allMovieListByLanguage = [];
  var languageMovieCubit = getIt<MovieByLanguageCubit>();
  late dynamic args;
  @override
  void initState() {
getInitArgument();
    super.initState();
  }
  getInitArgument()async{
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments;
      });
      Logger().f(args);
      languageMovieCubit.getMovieByLanguage(args);
  });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstant(
          isLeading: true,
          InkWell(
            onTap: () {},
            child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: Icon(
                  Icons.language_outlined,
                  color: ColorConstantss.red,
                )),
          ),(){Navigator.pop(context);}),
    body:BlocBuilder<MovieByLanguageCubit, LanguageMovieState>(
      builder: (context, state) {
        if (state is LanguageMovieLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Center(child: CupertinoActivityIndicator(color: ColorConstantss.red,radius: 15,),)
          ],);
            // Center(child: Text('Press the button to fetch data.'));
        }
        if (state is LanguageMovieLoaded) {
          allMovieListByLanguage =state.movies;
          Logger().d(allMovieListByLanguage.map((e) => e.title));
          Logger().d(allMovieListByLanguage.length);
          // Logger().w(allMovieListByLanguage);
          return allMovieListByLanguage.length !=0?
            // Center(child: Text("data"),);
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                        child:
                      GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: 250,
                      childAspectRatio: 0.7,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      // mainAxisSpacing: 20
                  ),
                  itemCount: allMovieListByLanguage.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
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
                                    builder: (context) => MovieDetails(allMovieListByLanguage[index].videoId??""),
                                  ));
                            },
                            child: CatchImageWithOutWidth(imageUrl: "${Globals.imageBaseUrl}${allMovieListByLanguage[index].thumbnail!}",
                                height:  systemHeight(15, context), isFree: false, )
                            // Container(
                            //
                            //
                            //   height: systemHeight(15, context),
                            //   // width: 80,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(8),
                            //       image: DecorationImage(fit: BoxFit.fill,image:
                            //       NetworkImage(
                            //       "${Globals.imageBaseUrl}"+ allMovieListByLanguage[index].thumbnail!,),
                            //       )),
                            // ),
                          ),
                          SizedBox(height: 5.0),
                          Expanded(
                            child: Text(
                              // "modelmodelmodelmodascefelmoddffasfwel",
                              allMovieListByLanguage[index].title??"",
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
                    //   Container(
                    //   // color: ColorConstants.red,
                    //   // height: 300,
                    //   // height: systemHeight(20, context),
                    //   // width: 100,
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child:
                    //   Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     // mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       InkWell(
                    //         onTap:(){
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => MovieDetails(allMovieListByLanguage[index].videoId??""),
                    //               ));
                    //         },
                    //         child: Container(
                    //
                    //
                    //           height: systemHeight(15, context),
                    //           // width: 80,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8),
                    //               image: DecorationImage(fit: BoxFit.fill,image:
                    //               NetworkImage("${Globals.imageBaseUrl}"+ allMovieListByLanguage[index].thumbnail!,),
                    //               )),
                    //         ),
                    //       ),
                    //       SizedBox(height: 5.0),
                    //       Expanded(
                    //         child: Text(
                    //           // "modelmodelmodelmodascefelmoddffasfwel",
                    //           allMovieListByLanguage[index].title??"",
                    //           maxLines: 2,softWrap: true,
                    //           overflow: TextOverflow.ellipsis,
                    //           style: TextStyle(
                    //             fontFamily: 'GeoBook',
                    //             fontSize: 12,
                    //             color: ColorConstantss.white,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }))])) :
          Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("No Movie Found Yet!!!"),)
          ],
          );

        } else {
          Logger().e("Unkonw state");
          return Center(child: Text('No Movie Found Yet!!!'));
        }
      },
    ),

    );
  }
}
