import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
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
         (){Navigator.pop(context);}),
    body:BlocBuilder<MovieByLanguageCubit, LanguageMovieState>(
      builder: (context, state) {
        if (state is LanguageMovieLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Center(child: CupertinoActivityIndicator(color: ColorConstantss.red,radius: 15.r,),)
          ],);
        }
        if (state is LanguageMovieLoaded) {
          allMovieListByLanguage =state.movies;
          Logger().d(allMovieListByLanguage.map((e) => e.title));
          Logger().d(allMovieListByLanguage.length);
          // Logger().w(allMovieListByLanguage);
          return allMovieListByLanguage.isNotEmpty?
            // Center(child: Text("data"),);
            Padding(
                padding:  EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Expanded(
                        child:
                      GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:130.h,
                      mainAxisExtent: 140.h,
                  // SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: 250,
                    //   childAspectRatio: 0.5.h,
                    //   crossAxisCount: 3,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w
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
                          Container(
                            height:125.h,
                            // height:systemHeight(14.h, context) ,

                            child: InkWell(
                              onTap:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetails(allMovieListByLanguage[index].videoId??""),
                                    ));
                              },
                              child: CatchImageWithOutWidth(imageUrl: "${Globals.imageBaseUrl}${allMovieListByLanguage[index].thumbnail!}",
                                   isFree: "0", )

                            ),
                          ),
                          SizedBox(height:1.h),
                          Expanded(
                            child: Text(
                              // "modelmodelmodelmodascefelmoddffasfwel",
                              allMovieListByLanguage[index].title??"",
                              maxLines: 1,softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'GeoBook',
                                fontSize: 10.sp,
                                color: ColorConstantss.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }))])) :
          const Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("No Movie Found Yet!!!"),)
          ],
          );

        } else {
          Logger().e("Unkonw state");
          return const Center(child: Text('No Movie Found Yet!!!'));
        }
      },
    ),

    );
  }
}
