// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shinestreamliveapp/data/models/otpmodel.dart';
// import 'package:shinestreamliveapp/ui/onboarding/changepassword.dart';
// import 'package:shinestreamliveapp/ui/onboarding/welcome_screen.dart';
// import 'package:shinestreamliveapp/ui/widget_components/bottomnavbar.dart';
// import '../../basescreen/base_screen.dart';
// import '../../cubit_bloc/otp_cubit/otp_cubit.dart';
// import '../../di/locator.dart';
// import '../../main.dart';
// import '../../utils/color_constants.dart';
// import '../../utils/font_family_constants.dart';
// import '../../utils/font_size_constants.dart';
//
// import '../../utils/shared_prefs.dart';
// import '../widget_components/button_widget.dart';
// import '../widget_components/text_field_components.dart';
//
// class OtpScreen extends StatefulWidget {
//   String otp = "";
//   String text = "";
//   bool fpscreen = false;
//
//   OtpScreen(this.otp, this.text, this.fpscreen, {Key? key}) : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends BaseScreen<OtpScreen> {
//   String otp = "";
//
//   TextEditingController otpController = TextEditingController();
//   bool otpError = false;
//   var otpCubit = getIt<OtpCubit>();
//   late TwoFactorOtpModel _model;
//   @override
//   void initState() {
//     otp = widget.otp;
//     print(otp);
//     Future<Null>.delayed(Duration.zero, () {
//       // _showSnackbar();
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           body: BlocListener<OtpCubit, OtpState>(
//             listener: (context, state) {
//               if(state is OtpVerifyLoading){
//                 print("Working Loading successssss");
//               }
//               if(state is OtpVerifyError){
//                 print("Working Error Success");
//               }
//               if (state is OtpVerifyLoaded) {
//                 _model = state.response;
//                 print("Status here");
//                 print(_model.status);
//                 print("Details Here");
//                 print(_model.details);
//                 if(_model.status == "Success")
//                   {
//                     prefs.setString(SharedConstants.mobileNumber, widget.text);
//                     if(widget.fpscreen == false){
//
//                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigation(index: 0)),(route) => false,);
//
//                     }
//                     else {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ChangePassword()));
//                     }
//
//                   }
//                 else{
//                   final snackBar = SnackBar(
//                     content: Text("" + _model.details),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }
//
//                 // LoaderWidget.showProgressIndicatorAlertDialog(context);
//               }
//
//               // TODO: implement listener
//             },
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.all(15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: systemHeight(5, context),
//                     ),
//                     Image.asset("assets/logomain.jpg", scale: 2.5),
//                     SizedBox(
//                       height: systemHeight(8, context),
//                     ),
//                     Center(
//                       child: Text(
//                         "An OTP been sent to " + widget.text,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             height: 1.2,
//                             fontFamily: FontFamilyConstants.interMedium,
//                             fontSize: FontSizeConstants.size20,
//                             color: ColorConstantss.heading),
//                       ),
//                     ),
//                     SizedBox(
//                       height: systemHeight(7, context),
//                     ),
//                     StreamBuilder(
//                         stream: otpCubit.smsOtpStream,
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             otpError = snapshot.data!;
//                           }
//                           return TextFieldComponent(
//                               prodNameController: otpController,
//                               hintText: "Enter OTP received on SMS",
//                               errorText: "Enter a OTP",
//                               errorTextShow: otpError,
//                               onchange: (value) {
//                                 //loginCubit.validateUserName(value);
//                                 otpCubit.validateSmsOtp(value);
//                               },
//                               inputtype: [],
//                               textInputType: TextInputType.number);
//                         }),
//                     SizedBox(
//                       height: systemHeight(10, context),
//                     ),
//                     CustomButton.getButton("Submit", ColorConstantss.white,
//                         ColorConstantss.red, systemWidth(95, context), () {
//                           if (!otpError) {
//                             otpCubit.verifyOtp(otp, otpController.text);
//                             print("Success");
//                           }
//                           else {
//                             otpCubit.validateSmsOtp(otpController.text);
//                             print("Failure");
//                           }
//                           //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()),(route) => false,);
//                         })
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
//
//   void _showSnackbar() {
//     final snackBar = SnackBar(
//       content: Text("Your OTP is " + otp),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
