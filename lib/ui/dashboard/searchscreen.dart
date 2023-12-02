import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/logger.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/ui/dashboard/moviedetails.dart';
import 'package:shinestreamliveapp/ui/dashboard/movieplay.dart';

import '../../data/api.dart';
import '../../data/models/allmoviemodel.dart';
import '../../data/models/searchlistmodel.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../widget_components/app_bar_components.dart';
import '../widget_components/catched_image.dart';
class SearchProfile extends StatefulWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  State<SearchProfile> createState() => _SearchProfileState();
}

class _SearchProfileState extends BaseScreen<SearchProfile> {
  late List<SearchModel> allMoviesModel = [];
  late List<SearchModel> newList = [];
  var movieCubit = getIt<MovieCubit>();


  @override
  initState() {
    movieCubit.allMovie();
    print("SEARCH CALLED ::==>");
    // at the beginning, all users are shown
    newList=allMoviesModel;
    super.initState();
  }
  @override
  void dispose() {
newList = [];
allMoviesModel = [];
    super.dispose();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<SearchModel>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allMoviesModel;
      setState(() {

      });
    } else {
      results = allMoviesModel
          .where((user) =>
          user.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {

      });
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      newList = results!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _onRefresh() async{
      movieCubit.allMovie();
      Logger().f('refreshing stocks...');

    }
    return Scaffold(
      appBar:AppBarConstantWithOutBackIcon(SizedBox(height: 1,width: 1,)),


      body:
      Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(72.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AppBar(
                elevation: 1,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor ,
                titleSpacing: 0,
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10, bottom: 15,left: 10),
                  child: TextField(cursorColor: ColorConstantss.white,
                    decoration: InputDecoration(
                        focusColor: ColorConstantss.white,
                        fillColor: ColorConstantss.heading.withOpacity(0.5),filled: true,
                        hoverColor: ColorConstantss.white,
                        hintText: 'Search here',
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstantss.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstantss.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstantss.red))),
                    onChanged: (value) => _runFilter(value),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(onRefresh: _onRefresh,color: ColorConstantss.red,
            
              child:
              BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
            
            
            
                     if(state is AllMoviesLoaded){
                       allMoviesModel = state.response;
                       if(newList.isEmpty)
                       newList = allMoviesModel;
                       return Padding(
                         padding: const EdgeInsets.all(10),
                         child: Column(
                           children: [
                             Expanded(
                               child: newList.isNotEmpty
                                   ?
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
                                   itemCount: newList.length,
                                   itemBuilder: (BuildContext ctx, index) {
                                     return
                                       Container(
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
                                                     builder: (context) => MovieDetails(newList[index].videoId??""),
                                                   ));
                                             },
                                             child:
                                             CatchImageWithOutWidth(
                                                 imageUrl: "${Globals.imageBaseUrl}${newList[index].thumbnail}",
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
                                               newList[index].title??"",
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
                                     //   height: 220,
                                     //   child: Column(
                                     //     children: [
                                     //       Text("data"),
                                     //       InkWell(
                                     //         onTap: (){
                                     //
                                     //           Navigator.push(
                                     //               context,
                                     //               MaterialPageRoute(
                                     //                 builder: (context) => MovieDetails(newList[index].videoId),
                                     //               ));
                                     //         },
                                     //         child: Image.network(
                                     //           "${Globals.imageBaseUrl}"+newList[index].thumbnail,
                                     //           fit: BoxFit.fill,
                                     //           height: 200,
                                     //         ),
                                     //       ),
                                     //     ],
                                     //   ),
                                     // );
                                   })
            
                                   : const Text(
                                 'No results found',
                                 style: TextStyle(fontSize: 24),
                               ),
                             ),
                           ],
                         ),
                       );
                     }
                     else{
                       return Container();
                     }
            
            
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
