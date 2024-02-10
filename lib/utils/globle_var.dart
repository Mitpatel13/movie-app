import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
class GlobleVar{
  InternetConnectionStatus? connectionStatus;
  late StreamSubscription<InternetConnectionStatus> subscription;
  bool isInternet = true;
}
