
// download_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinestreamliveapp/ui/widget_components/app_bar_components.dart';
import 'package:video_player/video_player.dart';

import '../../cubit_bloc/download_data/download_bloc.dart';

// class DownloadedVideosList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final directory = Directory(await getApplicationDocumentsDirectory().path);
//     final videos = directory.listSync();
//
//     return ListView.builder(
//     itemCount: videos.length,
//     itemBuilder: (context, index) {
//     return ListTile(
//     title: Text('Video ${index + 1}'),
//     onTap: () {
//     Navigator.push(
//     context,
//     MaterialPageRoute(
//     builder: (context) => VideoPlayerScreen(
//     videoPath: videos[index].path,
//     ),
//     ),
//     );
//     },
//     );
//     },
//     );
//   }
// }
//
// class VideoPlayerScreen extends StatelessWidget {
//   final String videoPath;
//
//   const VideoPlayerScreen({required this.videoPath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: VideoPlayerWidget(videoPath: videoPath),
//     );
//   }
// }
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoPath;
//
//   const VideoPlayerWidget({required this.videoPath});
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.videoPath))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: _controller.value.isInitialized
//           ? AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       )
//           : Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
//
// enum DownloadStatus {
//   none,
//   downloading,
//   paused,
//   completed,
//   failed,
// }

class DownloadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarConstantWithOutBackIcon(SizedBox(height: 1,width: 1,)),
      body:
      // BlocBuilder<DownloadCubit, DownloadState>(
      //   builder: (context, state) {
      //     if (state.status == DownloadStatus.loading) {
      //       return Center(child: CircularProgressIndicator(
      //
      //       ));
      //     } else if (state.status == DownloadStatus.loaded) {
      //       return
      //         state.downloads.isNotEmpty? ListView.builder(
      //         itemCount: state.downloads.length,
      //         itemBuilder: (context, index) {
      //           final item = state.downloads[index];
      //           return ListTile(
      //             title: Text(item.title),
      //             subtitle: Text(item.description),
      //             leading: Image.network(item.imagePath),
      //             trailing: Text(item.status),
      //             onTap: () {
      //               // context.read<DownloadCubit>().startDownload(
      //               //   item.title,
      //               //   item.description,
      //               //   item.url,
      //               //   item.imagePath,
      //               // );
      //             },
      //           );
      //         },
      //       ):SizedBox(child: Text("No Download Yet!!"),);
      //     } else {
      //       return Center(child: Text('Error loading data'));
      //     }
      //   },
      // ),

          /// for development
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("No Downloads Yet!!")),
        ],
      )

    );
  }
}



// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:shinestreamliveapp/ui/dashboard/moviedetails.dart';
// import 'package:shinestreamliveapp/utils/globle_var.dart';
//
// import '../../cubit_bloc/movie_cubit/movie_cubit.dart';
// import '../../di/locator.dart';
//
// class DownloadScreen extends StatefulWidget {
//   const DownloadScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DownloadScreen> createState() => _DownloadScreenState();
// }
//
// class _DownloadScreenState extends State<DownloadScreen> {
//   var movieCubit = getIt<MovieCubit>();
//   List<File> videoList = [];
//   @override
//   void initState() {
//     setState(() {
//       downloadedVideos = videoList;
//       Logger().d("FROM MOVIE ANYNOUMUS VIDEO LIST ${downloadedVideos.toList()}");
//
//
//
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
// videoList.isNotEmpty ?      Expanded(child: ListView.builder(itemBuilder: (context, index) =>
//     Text(index.toString()),itemCount: videoList.length,)) : Center(child: Text("No Downloads Yet!!"),)
//     ],),));
//   }
// }

//
// class DownloadScreen extends StatefulWidget with WidgetsBindingObserver {
//   @override
//   _DownloadScreenState createState() => _DownloadScreenState();
// }
//
// class _DownloadScreenState extends State<DownloadScreen> {
//   ReceivePort _port = ReceivePort();
//   List<Map> downloadsListMaps = [];
//
//   @override
//   void initState() {
//     super.initState();
//     task();
//     _bindBackgroundIsolate();
//     FlutterDownloader.registerCallback((id, status, progress, ) =>downloadCallback(id,status as DownloadTaskStatus?,progress,) ,);
//
//
//   }
//
//   @override
//   void dispose() {
//     _unbindBackgroundIsolate();
//     super.dispose();
//   }
//
//   void _bindBackgroundIsolate() {
//     bool isSuccess = IsolateNameServer.registerPortWithName(
//         _port.sendPort, 'downloader_send_port');
//     if (!isSuccess) {
//       _unbindBackgroundIsolate();
//       _bindBackgroundIsolate();
//       return;
//     }
//     _port.listen((dynamic data) {
//       String id = data[0];
//       DownloadTaskStatus status = data[1];
//       int progress = data[2];
//       String url = data[3];
//       var task = downloadsListMaps.where((element) => element['id'] == id);
//       for (var element in task) {
//         element['progress'] = progress;
//         element['status'] = status;
//         // element['url'] = url;
//         // Logger().d("RECIEVED URL${url}");
//         setState(() {});
//       }
//     });
//   }
//
//   static void downloadCallback(
//       String? id, DownloadTaskStatus? status, int? progress ) {
//     final SendPort? send =
//     IsolateNameServer.lookupPortByName('downloader_send_port');
//     send?.send([id, status, progress]);
//   }
//
//   void _unbindBackgroundIsolate() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//   }
//
//   Future task() async {
//     List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
//     getTasks?.forEach((_task) {
//       Map _map = Map();
//       _map['status'] = _task.status;
//       _map['progress'] = _task.progress;
//       _map['id'] = _task.taskId;
//       _map['filename'] = _task.filename;
//       _map['savedDirectory'] = _task.savedDir;
//       downloadsListMaps.add(_map);
//     });
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Offline Downloads'),
//       ),
//       body:BlocBuilder<DownloadCubit, DownloadState>(
//     builder: (context, state) {
//     if (state.isLoading) {
//     return Center(child: CircularProgressIndicator());
//     } else if (state.isError) {
//     return Center(child: Text('Error loading data'));
//     } else {
//     return state.items.isNotEmpty? ListView.builder(
//     itemCount: state.items.length,
//     itemBuilder: (context, index) {
//     final item = state.items[index];
//     return InkWell(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context) =>
//             MoviePlay(state.items[index].videoLink)
//           ,));
//      print(state.items[index].videoLink);
//       }
//       ,
//
//       child: ListTile(
//       title: Text(item.title),
//       // subtitle: Text(item.description),
//       // leading: Image.network(item.imageUrl),
//       ),
//     );
//     },
//     ): Center(child: Text("No Download yet!!"),);
//     }
//     },
//       // downloadsListMaps.length == 0
//       //     ? const Center(child: Text("No Downloads yet"))
//       //     : Container(
//       //   child: ListView.builder(
//       //     itemCount: downloadsListMaps.length,
//       //     itemBuilder: (BuildContext context, int i) {
//       //       Map _map = downloadsListMaps[i];
//       //       String _filename = _map['filename'];
//       //       int _progress = _map['progress'];
//       //       DownloadTaskStatus _status = _map['status'];
//       //       String _id = _map['id'];
//       //       String _savedDirectory = _map['savedDirectory'];
//       //       List<FileSystemEntity> _directories =
//       //       Directory(_savedDirectory).listSync(followLinks: true);
//       //       FileSystemEntity? file =
//       //       _directories.isNotEmpty ? _directories.first : null;
//       //       return GestureDetector(
//       //         onTap: () {
//       //           if (_status == DownloadTaskStatus.complete) {
//       //             showDialogue(file as File);
//       //           }
//       //         },
//       //         child: Card(
//       //           elevation: 10,
//       //           shape: const RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.all(Radius.circular(8))),
//       //           child: Column(
//       //             mainAxisAlignment: MainAxisAlignment.start,
//       //             crossAxisAlignment: CrossAxisAlignment.start,
//       //             children: <Widget>[
//       //               InkWell(
//       //                 onTap: (){
//       //                   if (_status == DownloadTaskStatus.complete) {
//       //                     Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePlay("movieLink"),));
//       //                   }
//       //
//       //                 },
//       //                 child: ListTile(
//       //                   isThreeLine: false,
//       //                   title: Text(_filename),
//       //                   subtitle: downloadStatus(_status),
//       //                   trailing: SizedBox(
//       //                     child: buttons(_status, _id, i),
//       //                     width: 60,
//       //                   ),
//       //                 ),
//       //               ),
//       //               // _status == DownloadTaskStatus.complete
//       //               //     ? Container()
//       //               //     : const SizedBox(height: 5),
//       //               _status == DownloadTaskStatus.complete
//       //                   ? Container()
//       //                   : Padding(
//       //                 padding: const EdgeInsets.all(8.0),
//       //                 child: Column(
//       //                   mainAxisAlignment: MainAxisAlignment.end,
//       //                   crossAxisAlignment: CrossAxisAlignment.end,
//       //                   children: <Widget>[
//       //                     Text('$_progress%'),
//       //                     Row(
//       //                       children: <Widget>[
//       //                         Expanded(
//       //                           child: LinearProgressIndicator(
//       //                             value: _progress / 100,
//       //                           ),
//       //                         ),
//       //                       ],
//       //                     ),
//       //                   ],
//       //                 ),
//       //               ),
//       //               const SizedBox(height: 10)
//       //             ],
//       //           ),
//       //         ),
//       //       );
//       //     },
//       //   ),
//       // ),
//     ));
//   }
//
//   Widget downloadStatus(DownloadTaskStatus _status) {
//     return _status == DownloadTaskStatus.canceled
//         ? const Text('Download canceled')
//         : _status == DownloadTaskStatus.complete
//         ? const Text('Download completed')
//         : _status == DownloadTaskStatus.failed
//         ? const Text('Download failed')
//         : _status == DownloadTaskStatus.paused
//         ? const Text('Download paused')
//         : _status == DownloadTaskStatus.running
//         ? const Text('Downloading..')
//         : const Text('Download waiting');
//   }
//
//   Widget buttons(DownloadTaskStatus _status, String taskid, int index) {
//     void changeTaskID(String taskid, String newTaskID) {
//       Map task = downloadsListMaps.firstWhere(
//             (element) => element['taskId'] == taskid,
//         // orElse: () => dynami,
//       );
//       task['taskId'] = newTaskID;
//       setState(() {});
//     }
//
//     return _status == DownloadTaskStatus.canceled
//         ? GestureDetector(
//       child: const Icon(Icons.cached, size: 20, color: Colors.green),
//       onTap: () {
//         FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
//           changeTaskID(taskid, newTaskID!);
//         });
//       },
//     )
//         : _status == DownloadTaskStatus.failed
//         ?
//     GestureDetector(
//       child:
//       const Icon(Icons.delete, size: 20, color: Colors.red),
//       onTap: () {
//         downloadsListMaps.removeAt(index);
//         FlutterDownloader.remove(
//             taskId: taskid, shouldDeleteContent: true);
//         setState(() {});
//       },
//     )
//     // GestureDetector(
//     //   child: const Icon(Icons.cached, size: 20, color: Colors.green),
//     //   onTap: () {
//     //     FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
//     //       changeTaskID(taskid, newTaskID??"");
//     //     });
//     //   },
//     // )
//         : _status == DownloadTaskStatus.paused
//         ? Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         GestureDetector(
//           child: const Icon(Icons.play_arrow,
//               size: 20, color: Colors.blue),
//           onTap: () {
//             FlutterDownloader.resume(taskId: taskid).then(
//                   (newTaskID) => changeTaskID(taskid, newTaskID!),
//             );
//           },
//         ),
//         GestureDetector(
//           child: const Icon(Icons.close, size: 20, color: Colors.red),
//           onTap: () {
//             FlutterDownloader.cancel(taskId: taskid);
//           },
//         )
//       ],
//     )
//         : _status == DownloadTaskStatus.running
//         ? Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         GestureDetector(
//           child: const Icon(Icons.pause,
//               size: 20, color: Colors.green),
//           onTap: () {
//             FlutterDownloader.pause(taskId: taskid);
//           },
//         ),
//         GestureDetector(
//           child:
//           const Icon(Icons.close, size: 20, color: Colors.red),
//           onTap: () {
//             FlutterDownloader.cancel(taskId: taskid);
//           },
//         )
//       ],
//     )
//         : _status == DownloadTaskStatus.complete
//         ? GestureDetector(
//       child:
//       const Icon(Icons.delete, size: 20, color: Colors.red),
//       onTap: () {
//         downloadsListMaps.removeAt(index);
//         FlutterDownloader.remove(
//             taskId: taskid, shouldDeleteContent: true);
//         setState(() {});
//       },
//     )
//         : Container();
//   }
//
// }