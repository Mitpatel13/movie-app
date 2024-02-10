import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/ui/dashboard/moviedetails.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';
import '../../data/api.dart';
import '../../data/models/allmoviemodel.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../widget_components/app_bar_components.dart';
import '../widget_components/catched_image.dart';

class SearchProfile extends StatefulWidget {
  const SearchProfile({super.key});

  @override
  State<SearchProfile> createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {
  late List<SearchModel> allMoviesModel = [];
  late List<SearchModel> newList = [];
  var movieCubit = getIt<MovieCubit>();
  late FocusNode searchFocusNode;


  @override
  initState() {
    searchFocusNode = FocusNode();
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
searchFocusNode.dispose();
    super.dispose();
  }

  // This function is called whenever the text field changes
  Future<void>runFilter(String enteredKeyword) async {
    List<SearchModel>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results =  allMoviesModel;
      setState(() {

      });
    } else {
      results = allMoviesModel
          .where((user) =>
          user.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
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

  final TextEditingController searchCTRL =TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _onRefresh() async{
      movieCubit.allMovie();
      Logger().f('refreshing stocks...');

    }
    return Scaffold(
      appBar:AppBarConstantWithOutBackIcon(SizedBox(height: 1.w,width: 1.w,)),


      body:

      Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(68.h),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 1,
                backgroundColor: Colors.black.withOpacity(0.5) ,
                titleSpacing: 0,
                centerTitle: false,
                title: Padding(
                  padding:  EdgeInsets.only(top: 15.h, right: 10.w, bottom: 15.h,left: 10.w),
                  child:
                  TextFormField(
                    controller: searchCTRL,

                      focusNode: searchFocusNode,
                    cursorColor: ColorConstantss.white,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              searchCTRL.clear();
                              runFilter('');
                              searchFocusNode.unfocus();
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey),
                        ),

                        focusColor: ColorConstantss.white,
                        fillColor: ColorConstantss.heading.withOpacity(0.5),filled: true,
                        hoverColor: ColorConstantss.white,
                        hintText: 'Search here',
                        contentPadding:  EdgeInsets.all(8.w),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstantss.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstantss.white)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide(
                                width: 0, color: ColorConstantss.white))),
                    onChanged: (value) {
                      setState(() {
                        runFilter(value);
                      });
                    }
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                 // double getDeviceWidth = MediaQuery.sizeOf(context).width;
                   if(state is AllMoviesLoaded){
                     allMoviesModel = state.response;
                     if(newList.isEmpty)
                     newList = allMoviesModel;
                     return Padding(
                       padding:  EdgeInsets.all(8.w),
                       child: Column(
                         children: [

                           ///letest grid
                           Expanded(
                             child: newList.isNotEmpty
                                 ?
                                 ///old and main grid view
                             GridView.builder(
                                 scrollDirection: Axis.vertical,
                                 physics: const
                                 ScrollPhysics(),
                                 shrinkWrap: true,
                                 gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:130.h,
                                     mainAxisExtent: 140.h,
                                     // maxCrossAxisExtent: 250,
                                     // childAspectRatio: MediaQuery.sizeOf(context).width / 520.w,
                                     // getDeviceWidth<400? 0.4.w : 0.5.w,
                                     //  crossAxisCount:3,
                                     crossAxisSpacing: 10.w,
                                     mainAxisSpacing: 10.w
                                  ),
                                 itemCount: newList.length,
                                 itemBuilder: (BuildContext ctx, index) {
                                   return
                                     Column(
                                       mainAxisSize: MainAxisSize.min,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Container(
                                           height:125.h,
                                           child: InkWell(
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
                                               isFree: "0", )
                                           ),
                                         ),
                                         const SizedBox(height:1),
                                         Expanded(
                                           child: Text(
                                             // "modelmodelmodelmodascefelmoddffasfwel",
                                             newList[index].title??"",
                                             maxLines: 1,
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
        ],
      ),
    );
  }
}
