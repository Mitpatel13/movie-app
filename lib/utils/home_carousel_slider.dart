import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../data/api.dart';
import '../ui/widget_components/catched_image.dart';
Widget homeCarouselSlider({required BuildContext context,required dynamic dataModel,required List<String> imgList,}){
  return CarouselSlider(
    options: CarouselOptions(
      autoPlayAnimationDuration:
      const Duration(seconds: 1),
      autoPlayCurve: Curves.linear,

      viewportFraction: 1,height: MediaQuery.sizeOf(context).height/1.5,
      autoPlay: true,
      reverse: false,
      autoPlayInterval:
      const Duration(seconds: 3),
      pauseAutoPlayOnTouch: true,
    ),
    items: List.generate(
      dataModel.length + (dataModel.length ~/ 2),
          (index) {
        if (index % 3 == 2) {
          int? imgIndex = index ~/ 3;
          imgIndex %= imgList.length; // Wrap around imgList2 indices

          return InkWell(
            onTap: () {
              Logger().d("ON TAP IMAGEINDEX IS $imgIndex");
            },
            child: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage(
                  // AppAsset.trialPoster
                  imgList[imgIndex],
                ),
                fit: BoxFit.fill,

              ),
            ),
          );
        }
        else{
          int modelIndex = index - (index ~/ 3);
          return
            SizedBox(
              // child: Text(hbModel[index].title??""),
              // color: Colors.red,
              width: double.infinity,
              child:
              CatchImageWithOutWidthForHomeBaner(
                imageUrl: "${Globals.imageBaseUrl}${dataModel[modelIndex].thumbnail}",),
            );
        }

      },
    ),
  );
}