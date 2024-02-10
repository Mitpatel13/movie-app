import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';
class CatchImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
   final String isFree;const CatchImage(
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
          imageBuilder: (context, imageProvider) {
          return Container(
            height:height,
            width:width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              image: DecorationImage( //image size fill
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),);
        },
        
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                height:height,
                width:width,
                // 100,
                child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.grey,
                    child: Center(child: CupertinoActivityIndicator(color: HexColor("#F22128"),radius: 8.r,animating: true,))
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        isFree == "1" ? Padding(
          padding:  EdgeInsets.all(1.w),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(AppAsset.freeImage,width: 30.w,)),
        ) : const SizedBox()
      ],
    );
  }
}
class CatchImageWithOutWidth extends StatelessWidget {
  final String imageUrl;
  final String isFree;
  const CatchImageWithOutWidth({super.key,
     required this.imageUrl,
     required this.isFree,

   });

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        CachedNetworkImage(
          imageUrl:imageUrl,
          imageBuilder: (context, imageProvider) {
          return Container(
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
                child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.grey,
                    child: Center(child: CupertinoActivityIndicator(color: HexColor("#F22128"),radius: 7.r,animating: true,))
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        isFree == "1" ? Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(AppAsset.freeImage,width: 35,)),
        ) : const SizedBox()
      ],
    );
  }
}
class CatchImageWithOutWidthForHomeBaner extends StatelessWidget {
  final String imageUrl;
  const CatchImageWithOutWidthForHomeBaner({super.key,
     required this.imageUrl,

   });

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        CachedNetworkImage(
          imageUrl:imageUrl,
          imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage( //image size fill
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),);
        },

          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.grey,
                    child: Center(child: CupertinoActivityIndicator(color: HexColor("#F22128"),radius: 10.r,animating: true,))
                ),
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ],
    );
  }
}
class CatchImageByPath extends StatelessWidget {
  final String imageUrl;
  const CatchImageByPath({super.key,required this.imageUrl,});

  @override
  Widget build(BuildContext context) {
    return
      CachedNetworkImage(
    imageUrl:imageUrl,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
    Shimmer.fromColors(
    baseColor: Colors.red,
    highlightColor: Colors.grey,
    child: Center(child: CupertinoActivityIndicator(color: HexColor("#F22128"),radius: 7.r,animating: true,))
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
);
  }
}

