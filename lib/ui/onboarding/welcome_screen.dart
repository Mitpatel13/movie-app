import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/ui/onboarding/forgotpassword.dart';

import '../../basescreen/base_screen.dart';
import '../../cubit_bloc/login_cubit.dart';
import '../../data/models/checkloginmodel.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/bottomnavbar.dart';
import '../widget_components/button_widget.dart';
import '../widget_components/text_field_components.dart';
import 'new_user.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends BaseScreen<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  late CheckLoginModel loginCheck;
  var loginCubit = getIt<LoginCubit>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //bool nameError = false;
  bool phoneError = false;
  bool passError = false;

  //bool phoneEditFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state is LoginLoading) {
            // LoaderWidget.showProgressIndicatorAlertDialog(context);
            CircularProgressIndicator();
          } else if (state is LoginLoaded) {
            var loginCheck = state.response;
            final snackBar = SnackBar(
              content: Text(loginCheck[0].msg),
            );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            if (!loginCheck[0].msg.contains("does not match")) {
              prefs.setString(SharedConstants.mobileNumber, phoneController.text);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParentWidget()));
            }
          } else if (state is LoginError) {
            // LoaderWidget.removeProgressIndicatorAlertDialog(context);
            var test = state.error;
            final snackBar = SnackBar(
              content: Text(test.toString()),
            );
            Logger().e(test);
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            // LoaderWidget.removeProgressIndicatorAlertDialog(context);
          }
        }, builder: (context, state) {
          return Container(
            margin:  EdgeInsets.all(15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeConstants.size28,
                          color: ColorConstantss.red,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Login to enjoy the World of Entertainment",
                        style: TextStyle(
                          color: ColorConstantss.newGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 17.h),
                      StreamBuilder(
                        stream: loginCubit.phoneStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            phoneError = snapshot.data!;
                          }
                          return TextFieldComponent(
                            prefixIcon: Icon(Icons.call, color: ColorConstantss.black, size: 20.w),
                            prodNameController: phoneController,
                            hintText: "Enter Mobile Number",
                            errorText: "Enter a valid Number",
                            errorTextShow: phoneError,
                            onchange: (value) {
                              loginCubit.validatePhoneNumber(value.trim());
                            },
                            inputtype: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                            textInputType: TextInputType.number,
                          );
                        },
                      ),
                      SizedBox(
                        height: systemHeight(0.6, context),
                      ),
                      StreamBuilder(
                        stream: loginCubit.passStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            passError = snapshot.data!;
                          }
                          return TextFieldComponent(
                            prefixIcon: Icon(Icons.lock_outline_sharp, color: ColorConstantss.black, size: 20.w),
                            prodNameController: passController,
                            hintText: "Enter Your Password",
                            errorText: "Enter a valid password",
                            errorTextShow: passError,
                            onchange: (value) {
                              loginCubit.validatePassword(value);
                            },
                            inputtype: const[],
                            textInputType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      SizedBox(
                        height: systemHeight(0.6, context),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                          print("forgot password clicked");
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: ColorConstantss.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomButton.getButton(
                        "Login Now",
                        ColorConstantss.white,
                        ColorConstantss.red,
                        systemWidth(50, context),
                            () {
                          FormData formData =  FormData.fromMap({
                            "email": phoneController.text,
                            "password": passController.text,
                          });

                          if (phoneController.text.isNotEmpty && passController.text.isNotEmpty) {
                            if (!phoneError && !passError) {
                              loginCubit.checkLogin(formData, context);
                            }
                          } else {
                            loginCubit.validatePassword(passController.text);
                            loginCubit.validatePhoneNumber(phoneController.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>const  NewUser(),
                            ),
                          );
                          print("new user clicked");
                        },
                        child: Text(
                          '    Register    ',
                          style: TextStyle(
                            fontFamily: FontFamilyConstants.interBold,
                            fontSize: FontSizeConstants.size18,
                            color: ColorConstantss.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

        }));
  }
}

