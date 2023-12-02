


import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';

class AppBarConstant extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final Widget actions;
  final void Function()? onBackNavigation;

  AppBarConstant(this.actions,this.onBackNavigation ,{Key? key,required this.isLeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger().d("isleading value${isLeading}");
    return AppBar(backgroundColor: Colors.white,
      automaticallyImplyLeading: isLeading == true ? true :false,
      leading:
          IconButton(onPressed: onBackNavigation, icon: Icon(Icons.arrow_back_rounded,color:isLeading ? Colors.black :Colors.transparent,)),
      title: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(AppAsset.logoMain,width: 130,)), centerTitle: true,
      actions: [
        isLeading ? SizedBox(width: 1,height: 1,) :actions
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
class AppBarConstantWithOutBackIcon extends StatelessWidget implements PreferredSizeWidget {
  final Widget actions;

  AppBarConstantWithOutBackIcon(this.actions,{Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                  child: Image.asset(AppAsset.logoMain,width: 130,)),
      centerTitle: true,
      actions: [
        actions
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}


