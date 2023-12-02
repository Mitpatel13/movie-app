import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
List<File> downloadedVideos = [];
class GlobleVar{
  InternetConnectionStatus? connectionStatus;
  late StreamSubscription<InternetConnectionStatus> subscription;
  bool isInternet = true;
  // List<File> downloadedVideos = [];
}
