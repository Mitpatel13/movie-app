import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/otp_cubit/otp_cubit.dart';
import 'package:shinestreamliveapp/data/models/otpmodel.dart';
import 'package:shinestreamliveapp/ui/onboarding/otpscreen.dart';

import '../../cubit_bloc/login_cubit.dart';
import '../../data/models/forgotpasswordmodel.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../widget_components/button_widget.dart';
import '../widget_components/text_field_components.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends BaseScreen<ForgotPassword> {
  var loginCubit = getIt<LoginCubit>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late List<ForgotPasswordModel> forgotPassModel = [];
  //bool nameError = false;
  bool phoneError = false;
  bool passError = false;
  var otpCubit = getIt<OtpCubit>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: systemHeight(5, context),
                  ),
                  Image.asset("assets/splashLogo.png", height: 165,),

                  // Image.asset("assets/logomain.jpg", scale: 2),
                  Container(
                      margin: EdgeInsets.all(systemHeight(3, context)),
                      child: Center(
                        child: Text(
                          "Shine Stream Live - Forgot Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: FontFamilyConstants.interBold,
                              fontSize: FontSizeConstants.size28,
                              color: ColorConstantss.red),
                        ),
                      )
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          //LoaderWidget.showProgressIndicatorAlertDialog(context);
                          CircularProgressIndicator();
                        }

                        else {
                          // LoaderWidget.removeProgressIndicatorAlertDialog(context);
                        }
                      }, builder: (context, state) {
                    return SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            StreamBuilder(
                                stream: loginCubit.phoneStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    phoneError = snapshot.data!;
                                  }
                                  return TextFieldComponent(
                                    prodNameController: phoneController,
                                    hintText: "Enter Mobile Number*",
                                    errorText: "Enter a valid Number",
                                    errorTextShow: phoneError,
                                    onchange: (value) {
                                      loginCubit.validatePhoneNumber(
                                          value.trim());
                                    },
                                    inputtype: [],
                                    textInputType: TextInputType.name,
                                  );
                                }),
                            SizedBox(
                              height: systemHeight(0.6, context),
                            ),


                            CustomButton.getButton(
                                "Submit", ColorConstantss.white,
                                ColorConstantss.red,
                                systemWidth(95, context), () {
                                  otpCubit.otpLoad(phoneController.text);
                            }
                            ),


                          ],
                        ),)
                      ,
                    );
                  }),
                ],
              ),
            )
        ));
  }
}
