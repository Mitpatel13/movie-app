import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';
import 'package:video_player/video_player.dart';
import '../data/api.dart';
import '../main.dart';

class OfflineMoviePlay extends StatefulWidget {
  final String movieLink;

   OfflineMoviePlay(this.movieLink, {super.key});

  @override
  State<OfflineMoviePlay> createState() => _MoviePlayState();
}

class _MoviePlayState extends State<OfflineMoviePlay> {
  late FlickManager flickManager;
  FlickLandscapeControls controller = const FlickLandscapeControls();
  late VideoPlayerController videoPlayerController;
  @override
  void initState(){
    super.initState();
    init();
  }
 init(){
  if (widget.movieLink.isNotEmpty) {
    videoPlayerController = VideoPlayerController.file(File(widget.movieLink));

    flickManager = FlickManager(
        videoPlayerController: videoPlayerController..initialize().then((_){
          setState(() {
            videoPlayerController.play();
          });
        })
    );
    AppLog.e(widget.movieLink);
}}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: CustomFlickVideoWithControls(controls: controller),
        wakelockEnabledFullscreen: true,
        preferredDeviceOrientation: const [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    videoPlayerController.dispose();
    flickManager.dispose();
    super.dispose();
  }
}

class CustomFlickVideoWithControls extends StatelessWidget {
  final FlickLandscapeControls controls;

  const CustomFlickVideoWithControls({Key? key, required this.controls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlickVideoWithControls(
      controls: controls,
      playerErrorFallback: Container(
        // Replace the color with your desired loading indicator color
        color: Colors.black,
        child: const Center(
          child: CupertinoActivityIndicator(
            color: Colors.red,
            animating: true,
            radius: 13,
          ),
        ),
      ),
      playerLoadingFallback: Container(
        // Replace the color with your desired loading indicator color
        color: Colors.black,
        child: const Center(
          child: CupertinoActivityIndicator(
            color: Colors.red,
            animating: true,
            radius: 13,
          ),
        ),
      ),
    );
  }
}
