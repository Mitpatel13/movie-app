import 'package:flutter/material.dart';
import 'package:shinestreamliveapp/ui/widget_components/bottomnavbar.dart';
import '../main.dart';
import '../utils/shared_prefs.dart';
import 'onboarding/welcome_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
{
  String mobileNumber = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => getSharedPreferenceData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
            child: Image.asset("assets/splashLogo.png",height: MediaQuery.sizeOf(context).height/4,),
          ),
    ));
  }
  void getSharedPreferenceData() async{
     mobileNumber = prefs.getString(SharedConstants.udid) ?? "";
    print("sharedPref uid$mobileNumber number in splash");
    print(mobileNumber);
    if(mobileNumber != "")
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ParentWidget()));
      }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  WelcomeScreen()));
    }
//check here if already logged in or not then navigate accordingly

  }
}