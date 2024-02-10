import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/data/models/homebannermodel.dart';
import 'package:shinestreamliveapp/data/repository/homerepository.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';

import 'package:shinestreamliveapp/ui/widget_components/app_bar_components.dart';
import 'package:shinestreamliveapp/utils/color_constants.dart';

import '../../cubit_bloc/home_cubit/home_cubit.dart';
import '../../data/api.dart';
import '../../di/locator.dart';
import '../widget_components/catched_image.dart';
import 'moviedetails.dart';
class ViewAllMovie extends StatefulWidget {
  String category;

   ViewAllMovie({super.key,required this.category});

  @override
  State<ViewAllMovie> createState() => _ViewAllMovieState();
}

class _ViewAllMovieState extends BaseScreen<ViewAllMovie>  with SingleTickerProviderStateMixin{
  HomeRepository  homeRepo = HomeRepository();
  var movieCubit = getIt<HomeCubit>();
   List<ActionMovieModel> actionModel = <ActionMovieModel>[];
  @override
  void initState() {
    init();
    super.initState();
  }
  init() async {
    if(widget.category == "Action Movies"){
     dynamic data = homeRepo.actionMovie();
      actionModel =await data;
     Logger().d(actionModel.map((e) => e.title));
     setState(() {

     });
    }
   else if(widget.category == "Classic Movies"){
      dynamic data = homeRepo.classicMovie();
      actionModel = await data;
      setState(() {

      });
    } else if(widget.category == "Comedy Movies"){
      dynamic data = homeRepo.comedyMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Crime Movies"){
      dynamic data = homeRepo.crimeMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Romantic Movies"){
      dynamic data = homeRepo.romanticMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Telugu Fav Movies"){
      dynamic data = homeRepo.telugufavMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Drama Movies"){
      dynamic data = homeRepo.dramaMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Kids Movies"){
      dynamic data = homeRepo.kidsMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Sports Movies"){
      dynamic data = homeRepo.sportsMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Devotional Movies"){
      dynamic data = homeRepo.devotionalMovie();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Folk Songs"){
      dynamic data = homeRepo.folkSongs();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Old Is Gold"){
      dynamic data = homeRepo.oldIsGold();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Best Hollywood"){
      dynamic data = homeRepo.bestHollywood();
      actionModel = await data;
      setState(() {

      });
    }
    else if(widget.category == "Best South"){
      dynamic data = homeRepo.bestSouth();
      actionModel = await data;
      setState(() {

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstant(
          isLeading: true,
             (){Navigator.pop(context);}),

    body: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          actionModel.isEmpty ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height/2.5,),

              Center(child: CupertinoActivityIndicator(color: ColorConstantss.red,
                radius: 15,animating: true,)),
            ],
          ):
          Expanded(
          child: Padding(
            padding:  EdgeInsets.all(8.w),
            child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:130.h,
                mainAxisExtent: 140.h,
            // SliverGridDelegateWithFixedCrossAxisCount(
            // crossAxisCount: 3,
            crossAxisSpacing: 10.w,
              // maxCrossAxisExtent: 150,
            mainAxisSpacing: 10.w
                ,
                childAspectRatio:0.5.h
                ),
                itemCount: actionModel.length,
                itemBuilder: (context, index) {
                return
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:125.h,
                        child: InkWell(
                          onTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetails(actionModel[index].videoId??""),
                                ));
                          },
                          child:CatchImageWithOutWidth(
                            // height:systemHeight(14.h, context) ,
                            imageUrl: "${Globals.imageBaseUrl}"+ actionModel[index].thumbnail!, isFree: "0",),
                        ),
                      ),
                      SizedBox(height:1),
                      Expanded(
                        child: Text(
                          // "modelmodelmodelmodascefelmoddffasfwel",
                          actionModel[index].title??"",
                          maxLines:1,
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
                  );
                }),
          ),
        )


        ],
      ),
    ),);
  }
}
