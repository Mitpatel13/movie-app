import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_size_constants.dart';


class CustomButton{
  static Widget getButton(
      String text, Color textcolor,Color buttoncolor,buttonwidth, onPressed) {
    return SizedBox(
      width: buttonwidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            padding:  EdgeInsets.symmetric(vertical:13.w,),
            primary: buttoncolor,
            onPrimary: ColorConstantss.white),
        child: Text(
          text,
          style: TextStyle(
              color: textcolor,
              fontFamily: 'barlow_semibold',
              fontWeight: FontWeight.bold,
              fontSize: FontSizeConstants.size14),
        ),
      ),
    );
  }


}