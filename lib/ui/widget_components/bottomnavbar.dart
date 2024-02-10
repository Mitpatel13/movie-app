
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';
import '../../utils/color_constants.dart';
import '../dashboard/downloadscreen.dart';
import '../dashboard/homescreen.dart';
import '../dashboard/profilescreen.dart';
import '../dashboard/searchscreen.dart';
import '../newHome/homescreen.dart';
class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigation(
      index: currentIndex,
      onIndexChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}

class BottomNavigation extends StatefulWidget {
   int index;
  final Function(int) onIndexChanged;

  BottomNavigation({required this.index, required this.onIndexChanged, super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final screens = const[
     HomeScreen(),
    DownloadScreen(),
    SearchProfile(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[widget.index],
      bottomNavigationBar: Container(
        height: 58.h,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
        ),
        child: ClipRRect(
          borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
          child: BottomNavigationBar(


            selectedIconTheme: IconThemeData(color: ColorConstantss.black),
            unselectedIconTheme: IconThemeData(
              color: ColorConstantss.white.withOpacity(0.5),
            ),
            unselectedItemColor: ColorConstantss.white.withOpacity(0.5),
            selectedItemColor: ColorConstantss.red,
            type: BottomNavigationBarType.fixed,
            currentIndex: widget.index,
            onTap: (index) {
              widget.onIndexChanged(index);
              setState(() {
                widget.index = index;
              });
            },
            backgroundColor: ColorConstantss.gray.withOpacity(0.2),
            items: [

              BottomNavigationBarItem(
                activeIcon: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,

                  onTap: () async {
                    widget.onIndexChanged(0);
                  },
                  child:Image.asset(AppAsset.homeFill,height: 25.h,width: 25.w,color: ColorConstantss.red)
                ),
                icon: Image.asset(AppAsset.homeFill,height: 25.h,width: 25.w,),
                label: "Home",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(AppAsset.downloadNotFill,height: 25.h,width: 25.w,color: ColorConstantss.red,),
                icon:Image.asset(AppAsset.downloadNotFill,height: 25.h,width: 25.w,),
                label: "Downloads",
              ),
              BottomNavigationBarItem(
                activeIcon:Image.asset(AppAsset.searchNotFill,height: 25.h,width: 25.w,color: ColorConstantss.red,),
                icon: Image.asset(AppAsset.searchNotFill,height: 25.h,width: 25.w,),
                label: "Search",
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(AppAsset.userNotFill,height: 25.h,width: 25.w,color: ColorConstantss.red,),
                icon:Image.asset(AppAsset.userNotFill,height: 25.h,width: 25.w,),
                label: "Profile",
              )
            ],
          ),
        ),
      ),
    );
  }
}


