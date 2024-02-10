import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/di/locator.dart';
import 'package:shinestreamliveapp/ui/onboarding/changepassword.dart';
import 'package:shinestreamliveapp/utils/font_size_constants.dart';
import 'package:shinestreamliveapp/utils/shared_prefs.dart';
import '../../cubit_bloc/profile_cubit/profile_cubit.dart';
import '../../data/repository/profilerepository.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../onboarding/welcome_screen.dart';
import '../profile/refund.dart';
import '../widget_components/app_bar_components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreen<ProfileScreen> {
  String? subScription;
  String? uid;
  String? userName;
  final profileRepo = getIt<ProfileRepository>();
  final profileCubit = getIt<ProfileCubit>();
  @override
  void initState() {
    super.initState();
onInit();
  }
  onInit()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    subScription =prefs.getString("${SharedConstants.subScription}");
    userName =prefs.getString("${SharedConstants.userName}")??"";
    uid =prefs.getString("${SharedConstants.udid}")??"";
    setState(() {

    });
    Logger().d("GET ALL DETAIL USERNAME == ${userName} subscription == ${subScription}  userId == ${uid}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarConstantWithOutBackIcon(SizedBox(height: 1.w,width: 1.w,)),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: systemHeight(3.h, context),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 2.h),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r),border: Border.all(color:
                  ColorConstantss.white)),
                  child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                      )
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 15.w,right: 15.w),
                child: Row(
                  children: [
                    Text(
                      userName??"",
                      style: TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'GeoBook',
                        fontSize: FontSizeConstants.size34,
                        color: ColorConstantss.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: systemHeight(1.h, context),
              ),
              Divider(color: Colors.white.withOpacity(0.5),),
              SizedBox(
                height: systemHeight(1.h, context),
              ),


              listBuild(Icons.question_mark, "About Us", "",
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScreen("About"),
                    ));
              }),
              listBuild(Icons.support_agent_sharp, "Help", "",
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScreen("Help"),
                    ));
              }),
              listBuild(
                  Icons.change_circle_rounded, "Return & Refund", "",() {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScreen("Refund"),
                    ));
                  }),
              listBuild(
                  Icons.change_circle_outlined, "Change Password", "",() {

                Navigator.push(context, MaterialPageRoute(builder: (context) =>const ChangePassword(),));

                  }),
              listBuild(
                  Icons.privacy_tip_outlined, "Privacy Policy", "",() {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScreen("Policy"),
                    ));
                  }),
              listBuild(Icons.terminal, "Terms & Conditions", "",
              () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScreen("Terms"),
                    ));
              }),
              listBuild(Icons.logout, "Logout", "",() {
                logout(context);
              }),
              // listBuild(Icons.logout, "Logout", "",() {
              //   FormData jsonBody = FormData.fromMap({"user_id": uid});
              //   profileRepo.logoutDeviceDecrement(jsonBody, context);
              //   prefs.clear();
              //   print("Logout Button Pressed");
              //
              //
              //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()),(route) => false,);
              //
              //
              // }),
            ],
          ),
        ));
  }
  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          // title: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Row(
          //       children: [
          //         Icon(Icons.logout,color: ColorConstantss.red,),
          //         SizedBox(width: 20.w,),
          //         Text("Logout"),
          //       ],
          //     ),
          //     Divider(color: ColorConstantss.grey,)
          //   ],
          // ),
          content: Text('Are you sure you want to Logout ?',style: TextStyle(fontSize: 11.sp),),
          actions: <Widget>[
            CupertinoDialogAction(

              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel",style: TextStyle(color: Colors.grey),),
            ),
            CupertinoDialogAction(
              onPressed: () {
                // Perform logout action here
                FormData jsonBody = FormData.fromMap({"user_id": uid});
                profileRepo.logoutDeviceDecrement(jsonBody, context);
                prefs.clear();
                print("Logout Button Pressed");
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()),(route) => false,);
              },
              child: Text("Yes",style: TextStyle(color: ColorConstantss.red),),
            ),
          ],
        );
      },
    );
  }

  listBuild(IconData img, String title, String url,void Function() onTap) {
    return InkWell(onTap: onTap,splashColor: Colors.transparent,highlightColor: Colors.transparent,
      child: Padding(
        padding:  EdgeInsets.all(13.r),
        child: Row(
          children: [
            Icon(img,color: Colors.white.withOpacity(0.9),),
            SizedBox(
              width: systemWidth(3.h, context),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: FontSizeConstants.size22,
                color: ColorConstantss.white.withOpacity(0.7)
                ,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
