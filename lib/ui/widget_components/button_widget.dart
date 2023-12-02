import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              borderRadius: BorderRadius.circular(7),
            ),
            padding: const EdgeInsets.all(15),
            primary: buttoncolor,
            onPrimary: ColorConstantss.white),
        child: Text(
          text,
          style: TextStyle(
              color: textcolor,
              fontFamily: 'barlow_semibold',
              fontWeight: FontWeight.w500,
              fontSize: FontSizeConstants.size14),
        ),
      ),
    );
  }


}