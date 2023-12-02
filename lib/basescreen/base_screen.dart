import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/size_configuration.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {


  //use system height and width to fit design for all screen size
  double systemWidth(percent, context) {
    SizeConfiguration().init(context);
    return (SizeConfiguration.safeBlockHorizontal! * percent);
  }

  double systemHeight(percent, context) {
    SizeConfiguration().init(context);
    return (SizeConfiguration.safeBlockVertical! * percent);
  }

  void size(BuildContext context) {}

}