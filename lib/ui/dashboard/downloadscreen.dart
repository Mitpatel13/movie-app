import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

import '../../video_library/offline_video_player.dart';

class Video {
  final int id;
  final String title;
  final String description;
  final String videoPath;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoPath': videoPath,
    };
  }
}

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();


  late Database _db;
  bool _isDatabaseOpen = false;

  Future<void> _openDatabase() async {
    _db = await openDatabase('videos.db', version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE IF NOT EXISTS videos (id INTEGER PRIMARY KEY, title TEXT, description TEXT, videoPath TEXT)');
        });
    // Update the flag indicating the database is now open
    _isDatabaseOpen = true;
  }

  Future<void> saveVideo(Video video) async {
    try {
      // Open or create the database if not already opened
      if (!_isDatabaseOpen) await _openDatabase();
      // Insert video data into the database
      await _db.insert('videos', video.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      AppLog.d('Videos saved: ${video.toMap()}');
    } catch (e) {
      AppLog.e('Error saving video: $e');
    }
  }

  Future<void> clearDownloadedVideos() async {
    try {
      // Open or create the database if not already opened
      if (!_isDatabaseOpen) await _openDatabase();
      // Drop the videos table
      await _db.execute('DROP TABLE IF EXISTS videos');
      // Recreate the videos table
      await _db.execute(
          'CREATE TABLE IF NOT EXISTS videos (id INTEGER PRIMARY KEY, title TEXT, description TEXT, videoPath TEXT)');
      AppLog.d('Downloaded videos cleared');
    } catch (e) {
      AppLog.e('Error clearing downloaded videos: $e');
    }
  }
  int _progress = 0;
  Future<String?> downloadAndSaveHLS(
      String url, String title, Function(double)? progressCallback) async {
    try {
      final FlutterFFmpegConfig _flutterFFmpegConfig = FlutterFFmpegConfig();
      final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

      // Get the temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;

      // Construct the output file path
      final String outputPath = '$tempPath/$title.mp4';

      // Attempt to delete the existing file
      try {
        await File(outputPath).delete();
      } catch (e) {
        // Handle any deletion errors, if necessary
        print('Error deleting existing file: $e');
      }

      final String command = '-i $url -c copy $outputPath';

      // Use a Completer to report completion
      Completer<String?> completer = Completer<String?>();


      // Start the FFmpeg execution asynchronously
      int executionId = await _flutterFFmpeg.executeAsync(
        command,
            (execution) async {
          if (execution.returnCode == 0) {
            completer.complete(outputPath);
          } else {
            completer.complete(null);
          }
        },
      );
      return completer.future;
    } catch (e, t) {
      print('Error downloading and saving HLS: $e');
      print('Trace: $t');
      return null;
    }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download and Play Videos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final String url =
                  "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8";
                  // "https://shinestreamlive.com/admin/file_folder/movies/GreenSignal/GreenSignal.m3u8";
              final String title = "vide11o";
              final videoPath = await downloadAndSaveHLS(url, title,(_) {});
              if (videoPath != null) {
                AppLog.d(videoPath);
                final video = Video(
                    id: 0,
                    title: title,
                    description: "",
                    videoPath: videoPath);
                await saveVideo(video);
              }
            },
            child: Text('Download and Play'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoListScreen(),
                ),
              );
            },
            child: Text('Show List'),
          ),
          ElevatedButton(
            onPressed: () async {
              await clearDownloadedVideos();
              setState(() {}); // Refresh UI
            },
            child: Text('Clear download list'),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  value: _progress.toDouble() / 100,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Text(
                '${_progress.toInt()}%',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoListScreen extends StatefulWidget {
  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late Future<List<Video>> videos;

  @override
  void initState() {
    super.initState();
    videos = getDownloadedVideos();
  }

  Future<List<Video>> getDownloadedVideos() async {
    try {
      final Database db = await openDatabase('videos.db');
      final List<Map<String, dynamic>> maps =
      await db.query('videos'); // Change table name to 'videos'
      AppLog.d(maps.toList());
      return List.generate(maps.length, (i) {
        return Video(
          id: maps[i]['id'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          videoPath: maps[i]['videoPath'],
        );
      });
    } catch (e) {
      AppLog.e('Error getting downloaded videos: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Videos'),
      ),
      body: FutureBuilder<List<Video>>(
        future: videos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No downloaded videos"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  onTap: () {
                    AppLog.d(snapshot.data![index].videoPath);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OfflineMoviePlay(
                            snapshot.data![index].videoPath),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

// class VideoPlayerScreen extends StatelessWidget {
//   final String videoPath;
//
//   VideoPlayerScreen({required this.videoPath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Player"),
//       ),
//       body: Center(
//         child: FutureBuilder(
//           future: VideoPlayerController.file(File(videoPath)).initialize(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               final VideoPlayerController controller =
//               VideoPlayerController.file(File(videoPath))..initialize();
//               return AspectRatio(
//                 aspectRatio: controller.value.aspectRatio,
//                 child: VideoPlayer(controller),
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }






