import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinestreamliveapp/ui/dashboard/view_all_movie_by_language.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';

import '../../basescreen/base_screen.dart';
import '../widget_components/app_bar_components.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

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
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBarConstant(
            isLeading: true,

         
                (){Navigator.pop(context);}),
        body:Center(
          child: Container(
            margin: EdgeInsets.all(8.w),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                // crossAxisCount: 2,
                maxCrossAxisExtent: 110.w,
                mainAxisSpacing: 10.w,
                // mainAxisExtent: 90.w,
                // childAspectRatio: 1.3,
                crossAxisSpacing: 10.w
                ,
                // mainAxisSpacing: 0
              ),
              itemBuilder: (BuildContext context, int index) {
                // final asset = images.keys.elementAt(index);
                // final value = images[asset];
                return InkWell(
                  splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAllMovieByLanguage(
                          ),settings: RouteSettings(arguments:images.values.elementAt(index) )));
                    },
                    child: Container(

                        decoration: BoxDecoration(border:
                        Border.all(color: Colors.white,),borderRadius: BorderRadius.circular(8.r)),
                        
                      
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.asset(images.keys.elementAt(index),fit: BoxFit.fill,)),));
              },
            ),
          ),
        ),
    );
  }
}
