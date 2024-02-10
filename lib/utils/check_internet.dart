

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/ui/widget_components/no_internet_ui_widget.dart';
import 'package:shinestreamliveapp/utils/globle_var.dart';

import '../ui/widget_components/bottomnavbar.dart';
Future<bool> onCheckInternet(context) async {
   bool isConnected = await InternetConnectionCheckerPlus().hasConnection;
   if(isConnected.toString() == "true"){
     Logger().d("IS INTERNET TRUE${isConnected}");
     return true;
   }
   else{
     // Logger().d(isConnected);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet Connection"))) ;

     return false;
   }
  // Logger().f(isConnected);

  // return isConnected;
}
  // void onCheckInternet(context)async{
  // // GlobleVar().subscription =
  //   InternetConnectionCheckerPlus().onStatusChange.listen((a) {
  //     if(a.toString() == "InternetConnectionStatus.connected"){
  //       Logger().f(a);
  //       // return true;
  //     }
  //     else {
  //       Logger().e(a.toString());
  //
  //       // return false;
  //     }
  //   });
  //
  //
  // }