import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';
import 'package:video_player/video_player.dart';
import '../data/api.dart';
import '../main.dart';

class MoviePlay extends StatefulWidget {
  final String? movieLink;

  MoviePlay(this.movieLink, {Key? key}) : super(key: key);

  @override
  State<MoviePlay> createState() => _MoviePlayState();
}

class _MoviePlayState extends State<MoviePlay> {
  late FlickManager flickManager;
  FlickLandscapeControls controller = const FlickLandscapeControls();
  late Timer _timer;
  int totalDurationInSeconds = 0;
  List<Map<String, dynamic>> savedVideos = [];
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    loadSavedData();

    AppLog.f("${Globals.imageBaseUrl}${widget.movieLink}");

    // Initialize the timer
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (flickManager.flickVideoManager!.videoPlayerController!.value.isPlaying) {
        setState(() {
          totalDurationInSeconds++;
        });
      }
    });
  }

  void _videoPlayerListener() {
    if (!flickManager.flickVideoManager!.videoPlayerController!.value.isPlaying) {
      // Video is stopped, pause the timer and save the current video details
      _timer.cancel();
      saveCurrentVideoDetails();
    } else if (_timer.isActive == false) {
      // Video is playing, resume the timer
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          totalDurationInSeconds++;
        });
      });
    }
  }

  void saveCurrentVideoDetails() {
    // Save the details of the current video to the list
    Map<String, dynamic> currentVideoDetails = {
      'name': 'Video Name${widget.movieLink}', // Replace with your video name
      'link': '${Globals.imageBaseUrl}${widget.movieLink}',
      'duration': totalDurationInSeconds,
    };

    // Update the existing details if the video is already in the list
    int existingIndex = savedVideos.indexWhere((video) => video['link'] == currentVideoDetails['link']);
    if (existingIndex != -1) {
      savedVideos[existingIndex] = currentVideoDetails;
      setState(() {
        AppLog.d('get video in index from list');
      });
    } else {
      // Add the video details to the list if it's not already present
      savedVideos.add(currentVideoDetails);
      setState(() {
        AppLog.d('add video in list');
      });
    }
  }

  void saveVideoDetails() {
    // Save the list of videos to SharedPreferences
    List<String> savedVideosJson = savedVideos.map((video) => jsonEncode(video)).toList();
    setState(() {
      prefs.setStringList('saved_videos', savedVideosJson);
      AppLog.d('saved_video $savedVideosJson');

    });

  }

  void loadSavedData() async {
    // Load the list of saved videos from SharedPreferences
    List<String>? savedVideosJson = prefs.getStringList('saved_videos');

    if (savedVideosJson != null) {
      savedVideos = savedVideosJson.map((json) => Map<String, dynamic>.from(jsonDecode(json))).toList();
    }

    // Find the saved details for the current video
    Map<String, dynamic>? savedVideoDetails = savedVideos.firstWhereOrNull(
          (video) => video['link'] == '${Globals.imageBaseUrl}${widget.movieLink}',
    );
    setState(() {});

    AppLog.d('get video detail from local $savedVideoDetails');

    if (savedVideoDetails != null) {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(savedVideoDetails['link']),
      );

      // Initialize the controller and seek to the desired duration
      flickManager = FlickManager(
          videoPlayerController: videoPlayerController..initialize().then((_){
            setState(() {
              videoPlayerController.seekTo(Duration(seconds: savedVideoDetails['duration']));
              videoPlayerController.play();
            });
          })
      );

      AppLog.e(savedVideoDetails['link']);
      AppLog.e(savedVideoDetails['duration']);
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('${Globals.imageBaseUrl}${widget.movieLink}'),
      );
      // Video details not found, play from the beginning
      flickManager = FlickManager(
        videoPlayerController: videoPlayerController..addListener(_videoPlayerListener),
        autoPlay: true,
      );
        AppLog.f('nodetail found play by default');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar:AppBar(
    //     title: Text('Movie Name'), // Replace 'Movie Name' with the actual name of the movie
    // leading: IconButton(
    // icon: Icon(Icons.arrow_back,size: 15.h,),    onPressed: () {
    // Navigator.of(context).pop();
    // },
    // ),
    // ),
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
    _timer.cancel();
    AppLog.f("Total video play duration after dispose $totalDurationInSeconds");
videoPlayerController.dispose();
    flickManager.dispose();
    saveVideoDetails();
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
