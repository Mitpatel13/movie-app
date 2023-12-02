import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';
class CatchImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
   final bool isFree;
   CatchImage(
  {super.key,
     required this.imageUrl,
     required this.height,
     required this.width,
    required this.isFree,

   });

  @override
  Widget build(BuildContext context) {
    return Stack(
      
      children: [
        CachedNetworkImage(
          imageUrl:imageUrl,
          // "${Globals.imageBaseUrl}"+
          //     model[index].thumbnail,
          imageBuilder: (context, imageProvider) {
          return Container(
            // margin: EdgeInsets.all(6),
            height:height,
            // systemHeight(15, context),
            width:width,
            // 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage( //image size fill
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),);
        },
        
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                height:height,
                // systemHeight(15, context),
                width:width,
                // 100,
                child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.grey,
                    child: Center(child: CupertinoActivityIndicator(color: HexColor("#F22128"),radius: 10,animating: true,))
                ),
              ),
          // CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        isFree ? Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(AppAsset.freeImage,width: 35,)),
        ) : SizedBox()
      ],
    );
  }
}
class CatchImageWithOutWidth extends StatelessWidget {
  final String imageUrl;
  final double height;
  final bool isFree;
  CatchImageWithOutWidth({super.key,
     required this.imageUrl,
     required this.height,
     required this.isFree,

   });

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        CachedNetworkImage(
          imageUrl:imageUrl,
          // "${Globals.imageBaseUrl}"+
          //     model[index].thumbnail,
          imageBuilder: (context, imageProvider) {
          return Container(
            // margin: EdgeInsets.all(6),
            height:height,
            // systemHeight(15, context),
            // 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage( //image size fill
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),);
        },

          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                height:height,
                // systemHeight(15, context),
                // 100,
                child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.grey,
                    child: Center(child: CupertinoActivityIndicator(color: HexColor("#F22128"),radius: 10,animating: true,))
                ),
              ),
          // CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        isFree ? Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(AppAsset.freeImage,width: 35,)),
        ) : SizedBox()
      ],
    );
  }
}
