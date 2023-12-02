
import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import '../dashboard/downloadscreen.dart';
import '../dashboard/homescreen.dart';
import '../dashboard/profilescreen.dart';
import '../dashboard/searchscreen.dart';

class BottomNavigation extends StatefulWidget {
  int index = 0;
  BottomNavigation({required this.index, Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // int currentIndex = ;
  final screens = [
     HomeScreen(),
     DownloadScreen(),
     SearchProfile(),
     ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[widget.index],
      // body: IndexedStack(
      //   index: widget.index,children: screens
      // ),
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            elevation: 10,
              selectedIconTheme: IconThemeData(color: ColorConstantss.black),
              unselectedIconTheme: IconThemeData(
                color: ColorConstantss.white.withOpacity(0.5),
              ),
              unselectedItemColor: ColorConstantss.white.withOpacity(0.5),
              selectedItemColor: ColorConstantss.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: widget.index,
              onTap: (index) => setState(() {
                widget.index = index;
              }),
              backgroundColor: ColorConstantss.gray.withOpacity(0.2),
              items: [

                BottomNavigationBarItem(

                  activeIcon: GestureDetector(
                    onTap: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigation(
                                index: 0,
                              )));
                    },
                    child: Icon(Icons.home,color: ColorConstantss.red)
                  ),
                  icon: Icon(Icons.home,color: ColorConstantss.white.withOpacity(0.5),),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.download,color: ColorConstantss.red),
                  icon: Icon(Icons.download,color: ColorConstantss.white.withOpacity(0.5)),
                  label: "Downloads",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.search,color: ColorConstantss.red),
                  icon: Icon(Icons.search,color: ColorConstantss.white.withOpacity(0.5)),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.person,color: ColorConstantss.red),
                  icon: Icon(Icons.person,color: ColorConstantss.white.withOpacity(0.5)),
                  label: "Profile",

                )
              ]),
        ),
      ),
    );
  }
}
