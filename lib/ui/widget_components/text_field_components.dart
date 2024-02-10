import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';

typedef Callback = void Function(String data);

class TextFieldComponent extends StatelessWidget {
  TextFieldComponent({
    super.key,
    required this.prodNameController,
    required this.hintText,
    required this.errorText,
    required this.errorTextShow,
    required this.onchange,
    required this.inputtype,
    required this.textInputType,
    this.prefixIcon

  });

  final TextEditingController prodNameController;
  String hintText, errorText;
  bool errorTextShow = false;
  Callback onchange;
  List<TextInputFormatter> inputtype = [];
  TextInputType textInputType;
  Widget? prefixIcon;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(elevation: 3,
          child: TextFormField(cursorColor: ColorConstantss.red,
            obscureText: hintText.contains("Pass")? true:false,

            inputFormatters: inputtype,
            maxLength: hintText.contains("Phone")?10:hintText.contains("OTP")?6:null,
            keyboardType: textInputType,
            controller: prodNameController,
            style: TextStyle(
                color: ColorConstantss.black,
                fontSize: FontSizeConstants.size14,
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(

              counterText: "",filled: true,fillColor: ColorConstantss.white.withOpacity(0.8),
              isDense: true,
              hintText: hintText,
              prefixIcon: prefixIcon,
              hintStyle: TextStyle(
                  fontFamily: FontFamilyConstants.interRegular,
                  color: ColorConstantss.black,
                  fontSize: FontSizeConstants.size14,
                  fontWeight: FontWeight.w400),
              errorText: errorTextShow==true?errorText:null,
              errorStyle: TextStyle(color: ColorConstantss.red,
                fontFamily: FontFamilyConstants.interRegular,
                fontSize: FontSizeConstants.size14,),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(
                      color: ColorConstantss.black)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(
                      color: ColorConstantss.black)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(
                      color: ColorConstantss.black)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide(
                      color: ColorConstantss.black)),
            ),

            onChanged:(data)=>onchange(data),


          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

}
