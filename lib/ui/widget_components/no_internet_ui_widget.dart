import 'package:flutter/material.dart';
import 'app_bar_components.dart';
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBarConstant(isLeading: false, (){}),
      body: const Column(
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
