import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/ui/onboarding/changepassword.dart';
import 'package:shinestreamliveapp/ui/payment/payment.dart';
import 'package:shinestreamliveapp/utils/font_size_constants.dart';
import 'package:shinestreamliveapp/utils/shared_prefs.dart';

import '../../main.dart';
import '../../utils/color_constants.dart';
import '../onboarding/welcome_screen.dart';
import '../profile/refund.dart';
import '../widget_components/app_bar_components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreen<ProfileScreen> {
  String? subScription;
  String? userName;
  @override
  void initState() {
    super.initState();
onInit();
  }
  onInit()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    subScription =prefs.getString("${SharedConstants.subScription}");
    userName =prefs.getString("${SharedConstants.userName}")??"";
    setState(() {
      
    });
    Logger().d(subScription);
    Logger().d(userName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarConstantWithOutBackIcon(SizedBox(height: 1,width: 1,)),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: systemHeight(3, context),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children: [
                    Text(
                      userName??"",
                      style: TextStyle(
                        fontFamily: 'GeoBook',
                        fontSize: FontSizeConstants.size29,
                        color: ColorConstantss.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                   //
                   //  Spacer(),
                   // InkWell(
                   //   onTap: (){
                   //     prefs.clear();
                   //     print("Logout Button Pressed");
                   //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()),(route) => false,);
                   //   },
                   //   child:  Icon(Icons.logout,size: 25,color: ColorConstantss.white,),
                   // )
                  ],
                ),
              ),
              SizedBox(
                height: systemHeight(3, context),
              ),
              listBuild(Icons.question_mark, "About Shine Stream Live", "",
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

                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(),));

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
                prefs.clear();
                print("Logout Button Pressed");
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()),(route) => false,);


              }),
            ],
          ),
        ));
  }

  listBuild(IconData img, String title, String url,void Function() onTap) {
    return InkWell(onTap: onTap,splashColor: Colors.transparent,highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(img),
            SizedBox(
              width: systemWidth(3, context),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'GeoBook',
                fontSize: FontSizeConstants.size22,
                color: ColorConstantss.white
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
