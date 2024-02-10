import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/otp_cubit/otp_cubit.dart';
import '../../cubit_bloc/login_cubit.dart';
import '../../data/models/forgotpasswordmodel.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../widget_components/button_widget.dart';
import '../widget_components/text_field_components.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

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
    return Scaffold(
        bottomSheet: Text(
            "Shine Stream Live",
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorConstantss.red,
              fontWeight: FontWeight.w400,
            )
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                //LoaderWidget.showProgressIndicatorAlertDialog(context);
                CupertinoActivityIndicator(color: ColorConstantss.red,radius: 13.r,);
              }

              else {
                // LoaderWidget.removeProgressIndicatorAlertDialog(context);
              }
            }, builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      Text(
                        "Forgot Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: FontFamilyConstants.interBold,
                            fontSize: FontSizeConstants.size28,
                            color: ColorConstantss.red),
                      ),
                      StreamBuilder(
                          stream: loginCubit.phoneStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              phoneError = snapshot.data!;
                            }
                            return TextFieldComponent(
                              prefixIcon: Icon(Icons.call,color: ColorConstantss.black,size: 20.w,),
                              prodNameController: phoneController,
                              hintText: "Enter Mobile Number",
                              errorText: "Enter a valid Number",
                              errorTextShow: phoneError,
                              onchange: (value) {
                                loginCubit.validatePhoneNumber(
                                    value.trim());
                              },
                              inputtype: const[],
                              textInputType: TextInputType.number,
                            );
                          }),
                      SizedBox(
                        height: systemHeight(0.6, context),
                      ),


                      CustomButton.getButton(
                          "Submit", ColorConstantss.white,
                          ColorConstantss.red,
                          systemWidth(50, context), () {
                        otpCubit.otpLoad(phoneController.text);
                      }
                      ),
                    ],
                  ),
                ),
              ),


            ],
          );
        })
    );
  }
}
