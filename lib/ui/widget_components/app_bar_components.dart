


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';


class AppBarConstant extends StatelessWidget implements PreferredSizeWidget {
  final bool isLeading;
  final void Function()? onBackNavigation;

  const AppBarConstant(this.onBackNavigation ,{Key? key,required this.isLeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.r),bottomLeft: Radius.circular(20.r))),
      automaticallyImplyLeading: isLeading == true ? true :false,
      leading:
          IconButton(onPressed: onBackNavigation, icon: Icon(Icons.arrow_back_rounded,color:isLeading ? Colors.black :Colors.transparent,)),
      title: Image.asset(AppAsset.logoMain,width: 120.w,), centerTitle: true,
      actions:const [
      ],
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(40.h);
}
class AppBarConstantWithOutBackIcon extends StatelessWidget implements PreferredSizeWidget {
  final Widget actions;

  const AppBarConstantWithOutBackIcon(this.actions,{super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.r),bottomLeft: Radius.circular(20.r))),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Image.asset(AppAsset.logoMain,width: 120.w,),
      centerTitle: true,
      actions: [
        actions
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}


