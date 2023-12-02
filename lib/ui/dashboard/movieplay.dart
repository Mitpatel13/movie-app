import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/utils/color_constants.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../data/api.dart';
class MoviePlay extends StatefulWidget {
  String movieLink;
  MoviePlay(this.movieLink, {Key? key}) : super(key: key);

  @override
  State<MoviePlay> createState() => _MoviePlayState();
}

class _MoviePlayState extends BaseScreen<MoviePlay> {
   late final VideoPlayerController _videoPlayerController;


   @override
  void initState(){
    Logger().d("https://www.shinestreamlive.com/${widget.movieLink}");

    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      // Uri.parse("${Globals.imageBaseUrl}${widget.movieLink}"),
        // "https://www.shinestreamlive.com/${widget.movieLink}"
    )..initialize().then((value) {
      _videoPlayerController.play();
      setState(() {});

    });

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:
        _videoPlayerController.value.isInitialized
            ?
        Chewie(controller:
        ChewieController(

            showControls: true,showOptions: true,autoInitialize: true,

            fullScreenByDefault: true,
            // materialProgressColors:
        // ChewieProgressColors(bufferedColor: ColorConstantss.red,
        //     playedColor: ColorConstantss.red,),
            allowPlaybackSpeedChanging: true,


            videoPlayerController: _videoPlayerController,allowFullScreen:
            true,autoPlay: true,),)
            : Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: MediaQuery.sizeOf(context).height/30,),
                Center(
                  child: CupertinoActivityIndicator(color: ColorConstantss.red,
                    radius: 15,
                    animating: true,),
                ),
              ],
            )
    );
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _videoPlayerController.dispose();

    super.dispose();
  }
}
