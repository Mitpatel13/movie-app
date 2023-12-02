import 'package:flutter/material.dart';
import 'package:shinestreamliveapp/utils/check_internet.dart';

import 'app_bar_components.dart';
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    // onCheckInternet(setState, context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBarConstant(isLeading: false,
          InkWell(
            onTap: () {},
          ), (){}),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("No Internet Connection"),
          )
        ],
      ),
    ));
  }
}
