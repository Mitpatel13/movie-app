import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/profile_cubit/profile_cubit.dart';
import 'package:shinestreamliveapp/data/models/aboutmodel.dart';
import 'package:shinestreamliveapp/data/models/policymodel.dart';
import 'package:shinestreamliveapp/data/models/refundmodel.dart';
import 'package:shinestreamliveapp/data/models/termsmodel.dart';

import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_size_constants.dart';
import '../widget_components/app_bar_components.dart';

class DisplayScreen extends StatefulWidget {
  String s;
  DisplayScreen(this.s, {super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends BaseScreen<DisplayScreen> {
  var profileCubit = getIt<ProfileCubit>();
  late List<RefundModel> refundData = [];
  late List<TermsModel> termsData = [];
  late List<AboutModel> aboutData = [];
  late List<PolicyModel> policyData = [];

  @override
  void initState() {
    if (widget.s == "Refund") {
      profileCubit.getRefund();
    }
    if (widget.s == "Policy")
    {
      profileCubit.getPolicy();
    }
    if (widget.s == "About")
    {
      profileCubit.getAbout();
    }
    if (widget.s == "Terms")
    {
      profileCubit.getTerms();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:
        AppBarConstant(
            isLeading: true,
           (){Navigator.pop(context);}),
        body: widget.s != "Help"?SingleChildScrollView(
          child: MultiBlocListener(
              listeners:[
                BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is RefundLoading) {
                    }
                  },

                ),

              ],
              child:
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if(state is RefundLoaded)
                  {
                    refundData = state.response;
                    return displayContent(refundData[0].refund);
                  }
                  else if(state is PolicyLoaded){
                    policyData = state.response;
                    return displayContent(policyData[0].policy);
                  }
                  else if(state is AboutLoaded){
                    aboutData = state.response;
                    return displayContent(aboutData[0].about??'');
                  }
                  else if(state is TermsLoaded){
                    termsData = state.response;
                    return displayContent(termsData[0].terms);
                  }
                  else{
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.sizeOf(context).height / 3,),
                        Center(child: CupertinoActivityIndicator(color: ColorConstantss.red,

                          radius: 15,animating: true,)),
                      ],
                    );
                  }

                },
              )
          ),
        ):
        Container(
          height: systemHeight(32, context),
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: ColorConstantss.red),
              borderRadius: BorderRadius.all(Radius.circular(18.r)),
            ),
            margin: EdgeInsets.all(18.r),
          child:Padding(
            padding:  EdgeInsets.only(top:8.h,right:8.h,bottom: 8.h,left: 17.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: systemHeight(2, context)),
                  child: Text("Contact Us",
                    style: TextStyle(
                        color: ColorConstantss.white,
                        fontFamily: 'barlow_semibold',
                        fontWeight: FontWeight.w700,
                        fontSize: FontSizeConstants.size17),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: systemHeight(2, context)),
                  child: Text("Shine Stream Live",
                    style: TextStyle(
                        color: ColorConstantss.white,
                        fontFamily: 'barlow_semibold',
                        fontWeight: FontWeight.w700,
                        fontSize: FontSizeConstants.size17),),
                ),
                SizedBox(
                  height: systemHeight(2, context),
                ),
                getText("Company Name : ", " Sunshine BroadCasting"),
                getText("Contact Person Name :", " Prasad"),
                getText("Mobile No :", " +91-9618114410"),
                getText("Email Id :", " appsun31@gmail.com"),





              ],
            ),
          )
        )


    );
  }

  Widget displayContent(String text) {
    return Container(
      margin: EdgeInsets.all(8.w),
      child: Text(_parseHtmlString(text),textAlign: TextAlign.justify,style: TextStyle(
        fontFamily: 'GeoBook',
        fontSize: 16,
        color: ColorConstantss.white,
        fontWeight: FontWeight.w400,
      ),),
    );
  }
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement!.text;

    return parsedString;
  }

  getText(String s, String t) {
    return Row(
      children: [
        SizedBox(
          height: systemHeight(4, context),
        ),
        Text(s,
            style: TextStyle(
                color: ColorConstantss.white,
                fontFamily: 'barlow_semibold',
                fontWeight: FontWeight.w500,
                fontSize: FontSizeConstants.size16)),
        Text(t,
            style: TextStyle(
                color: ColorConstantss.white,
                fontFamily: 'barlow_semibold',
                fontWeight: FontWeight.w400,
                fontSize: FontSizeConstants.size14))
      ],
    );
  }
}
