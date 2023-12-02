import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinestreamliveapp/ui/dashboard/view_all_movie.dart';
import 'package:shinestreamliveapp/ui/dashboard/view_all_movie_by_language.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';

import '../../basescreen/base_screen.dart';
import '../../utils/color_constants.dart';
import '../widget_components/app_bar_components.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends BaseScreen<LanguageSelection> {
  Map<String ,int> images = {
    AppAsset.teluguLang:2,
    AppAsset.englishLang:3,
    AppAsset.kannadaLang:4,
    AppAsset.tamilLang:5,
    AppAsset.hindiLang:6,
    AppAsset.malayalamLang:7,
    AppAsset.koreanLang:8,
    AppAsset.punjabiLang:9,
    AppAsset.gujuratiLang:10,
    AppAsset.marathiLang:11,
    AppAsset.nepaliLang:12,
    AppAsset.bhojPuriLang :13,
    AppAsset.odiaLang:14,
    AppAsset.banjaraLang : 15,
    
    
    
    // "assets/language/Banjara Poster.png",
    // "assets/language/Bhojpuri Poster.png",
    // "assets/telugu.png",
    // "assets/hindi.png",
    // "assets/kannada.png",
    // "assets/korean.png",
    // "assets/malayalam.png",
    // "assets/odia.png",
    // "assets/punjabi.png",
    // "assets/tamil.png",
    // "assets/bhojpuri.png",
    // "assets/bengali.png",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBarConstant(
            isLeading: true,

          SizedBox(),
                (){Navigator.pop(context);}),
        body:Center(
          child: Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,mainAxisExtent: 150,
                // childAspectRatio: 1.3,
                crossAxisSpacing: 20,
                // mainAxisSpacing: 0
              ),
              itemBuilder: (BuildContext context, int index) {
                // final asset = images.keys.elementAt(index);
                // final value = images[asset];
                return InkWell(
                  splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllMovieByLanguage(
                          ),settings: RouteSettings(arguments:images.values.elementAt(index) )));
                    },
                    child: Image.asset(images.keys.elementAt(index)));
              },
            ),
          ),
        ),
    );
  }
}
